/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 */

package org.openmrs.module.pihlesotho.activator;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.openmrs.api.context.Context;
import org.openmrs.module.reporting.ReportingConstants;
import org.openmrs.module.reporting.config.ReportLoader;
import org.openmrs.module.reporting.dataset.definition.SqlFileDataSetDefinition;
import org.openmrs.module.reporting.evaluation.parameter.Mapped;
import org.openmrs.module.reporting.evaluation.parameter.Parameter;
import org.openmrs.module.reporting.report.ReportDesign;
import org.openmrs.module.reporting.report.definition.ReportDefinition;
import org.openmrs.module.reporting.report.definition.service.ReportDefinitionService;
import org.openmrs.module.reporting.report.manager.ReportManager;
import org.openmrs.module.reporting.report.manager.ReportManagerUtil;
import org.openmrs.module.reporting.report.util.ReportUtil;
import org.openmrs.util.OpenmrsUtil;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Initializes reports
 */
public class ReportInitializer {
	
	protected static final Log log = LogFactory.getLog(ReportInitializer.class);

	public synchronized void started() {
		loadReportsFromCode();
		loadReportsFromClasspath();
		loadReportsFromApplicationData();
		ReportUtil.updateGlobalProperty(ReportingConstants.GLOBAL_PROPERTY_DATA_EVALUATION_BATCH_SIZE, "-1");
	}
	
	public static void loadReportsFromCode() {
		for (ReportManager reportManager : Context.getRegisteredComponents(ReportManager.class)) {
			if (reportManager.getClass().getAnnotation(Deprecated.class) != null) {
				log.warn("Report " + reportManager.getName() + " is deprecated.  Removing it from use.");
				removeReport(reportManager);
			} else {
				log.warn("Setting up report " + reportManager.getName() + "...");
				ReportManagerUtil.setupReport(reportManager);
			}
		}
	}
	
	public static void loadReportsFromClasspath() {
		PathMatchingResourcePatternResolver resourceResolver = new PathMatchingResourcePatternResolver();
		try {
			String reportPath = "classpath*:/org/openmrs/module/pihlesotho/reporting/reports/*";
			Resource[] resources = resourceResolver.getResources(reportPath);
			if (resources != null) {
				for (Resource r : resources) {
					log.info("Loading SQL Report from classpath: " + r.getFilename());
					List<String> lines = IOUtils.readLines(r.getInputStream(), "UTF-8");
					loadSqlReport(r.getFilename(), lines);
				}
			}
		}
		catch (Exception e) {
			throw new IllegalStateException("Unable to load SQL reports from classpath", e);
		}
	}
	
	public static void loadReportsFromApplicationData() {
		File reportDir = getPihLesothoConfigDirectory("reports");
		if (reportDir.exists() && reportDir.isDirectory()) {
			for (File file : reportDir.listFiles()) {
				try {
					log.info("Loading SQL report from application data: " + file.getAbsolutePath());
					List<String> lines = FileUtils.readLines(file, "UTF-8");
					loadSqlReport(file.getName(), lines);
				}
				catch (Exception e) {
					log.warn("Error loading file: " + file.getAbsolutePath(), e);
				}
			}
		}
		ReportLoader.loadReportsFromConfig();
	}
	
	/**
	 * Load in the lines of a SQL file with specific comments and use it to construct a report
	 * definition
	 * 
	 * @param lineByLineContents
	 */
	public static void loadSqlReport(String fileName, List<String> lineByLineContents) {
		
		try {
			ReportDefinition rd = new ReportDefinition();
			String designUuid = null;
			StringBuilder sql = new StringBuilder();
			boolean deprecated = false;
			
			for (String line : lineByLineContents) {
				if (line.startsWith("-- ##")) {
					String[] keyValue = StringUtils.splitByWholeSeparator(line.substring(5, line.length()), "=");
					String key = keyValue[0].trim().toLowerCase();
					String value = keyValue[1].trim();
					if (key.equals("report_uuid")) {
						rd.setUuid(value);
					} else if (key.equals("report_name")) {
						rd.setName(value);
					} else if (key.equals("report_description")) {
						rd.setDescription(value);
					} else if (key.equals("parameter")) {
						String[] paramElements = StringUtils.splitByWholeSeparator(value, "|");
						Parameter p = new Parameter();
						p.setName(paramElements[0]);
						p.setLabel(paramElements[1]);
						p.setType(Context.loadClass(paramElements[2]));
						rd.addParameter(p);
					} else if (key.equals("design_uuid")) {
						designUuid = value;
					} else if (key.equalsIgnoreCase("DEPRECATED")) {
						deprecated = true;
					}
				}
				sql.append(line).append(System.getProperty("line.separator"));
			}
			
			if (rd.getUuid() == null || rd.getName() == null || designUuid == null) {
				throw new IllegalArgumentException("SQL resource" + fileName
				        + " must define a report_name, report_uuid and design_uuid at minimum");
			}
			
			SqlFileDataSetDefinition dsd = new SqlFileDataSetDefinition();
			dsd.setSql(sql.toString());
			dsd.setParameters(rd.getParameters());
			rd.addDataSetDefinition("", Mapped.mapStraightThrough(dsd));
			
			List<ReportDesign> designs = new ArrayList<ReportDesign>();
			designs.add(ReportManagerUtil.createExcelDesign(designUuid, rd));
			
			if (deprecated) {
				removeReport(rd.getUuid());
			} else {
				ReportManagerUtil.setupReportDefinition(rd, designs, null);
			}
		}
		catch (Exception e) {
			throw new IllegalStateException("Error loading report at: " + fileName, e);
		}
	}
	
	public static void removeReport(ReportManager reportManager) {
		ReportDefinition rd = reportManager.constructReportDefinition();
		removeReport(rd.getUuid());
	}
	
	public static void removeReport(String reportUuid) {
		if (StringUtils.isNotBlank(reportUuid)) {
			ReportDefinitionService rds = Context.getService(ReportDefinitionService.class);
			ReportDefinition rd = rds.getDefinitionByUuid(reportUuid);
			if (rd != null) {
				Context.getService(ReportDefinitionService.class).purgeDefinition(rd);
			}
		}
	}
	
	public static File getPihLesothoConfigDirectory(String subdir) {
		File configDir = OpenmrsUtil.getDirectoryInApplicationDataDirectory("configuration");
		File lesothoDir = new File(configDir, "pihlesotho");
		return new File(lesothoDir, subdir);
	}
}
