<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="View Data Entry Statistics" otherwise="/login.htm" redirect="/module/@MODULE_ID@/dataEntryStatistics.list" />

<%@ include file="/WEB-INF/template/header.jsp" %>

<%@ include file="/WEB-INF/view/admin/maintenance/localHeader.jsp" %>

<openmrs:htmlInclude file="/scripts/calendar/calendar.js" />
<openmrs:htmlInclude file="/scripts/validation.js" />

<h2>Data Entry Statistics</h2>

<form method="post">

<table>
	<tr>
		<td>Encounter User:</td>
		<td>
			<spring:bind path="command.encUserColumn">			
				<select name="${status.expression}" width="10">
					<option value="creator" <c:if test="${command.encUserColumn=='creator'}">selected</c:if>>Data Entry Assistant</option>
					<option value="provider" <c:if test="${command.encUserColumn=='provider'}">selected</c:if>>Provider</option>
				</select>
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if> 
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td>Order User:</td>
		<td>
			<spring:bind path="command.orderUserColumn">			
				<select name="${status.expression}" width="10">
					<option value="creator" <c:if test="${command.orderUserColumn=='creator'}">selected</c:if>>Data Entry Assistant</option>
					<option value="orderer" <c:if test="${command.orderUserColumn=='orderer'}">selected</c:if>>Orderer</option>
				</select>
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if> 
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td>Group By:</td>
		<td>
			<spring:bind path="command.groupBy">
				<select name="${status.expression}" width="10">
					<option value="" <c:if test="${command.groupBy==''}">selected</c:if>></option>
					<option value="location" <c:if test="${command.groupBy=='location'}">selected</c:if>><spring:message code="Encounter.location"/></option>
				</select>
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if> 
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td><spring:message code="general.fromDate"/>:</td>
		<td>
			<spring:bind path="command.fromDate">
				<input type="text" name="${status.expression}" size="10" 
					   value="${status.value}" onClick="showCalendar(this)" />
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if> 
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td><spring:message code="general.toDate"/>:</td>
		<td>
			<spring:bind path="command.toDate">
				<input type="text" name="${status.expression}" size="10" 
					   value="${status.value}" onClick="showCalendar(this)" />
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if> 
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td>Hide Average Obs:</td>
		<td>
			<spring:bind path="command.hideAverageObs">
				<input type="hidden" name="_${status.expression}" />
				<input type="checkbox" name="${status.expression}" <c:if test="${status.value}">checked</c:if> />
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if> 
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" value="<spring:message code="general.view"/>" /></td>
	</tr>
</table>

</form>

<p/>

<c:out value="${command.table.htmlTable}" escapeXml="false"/>

<%@ include file="/WEB-INF/template/footer.jsp" %>
