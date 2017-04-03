<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@ include file="init.jsp" %>
<%@ page import="com.liferay.portal.kernel.util.Constants" %>


<liferay-portlet:actionURL portletConfiguration="<%= true %>" var="configurationActionURL" />

<br/>

<aui:form action="<%= configurationActionURL %>" method="post" name="configurationFm">

    <aui:input name="<%= Constants.CMD %>" type="hidden"
        value="<%= Constants.UPDATE %>" />


    <aui:fieldset>
    	<aui:input lable ="notificationURL" name="notificationURL" type="text" value="<%=GetterUtil.getString(portletPreferences.getValue("notificationURL", "")) %>"/>
    	
    </aui:fieldset>
    <aui:button-row>
        <aui:button type="submit"></aui:button>
    </aui:button-row>
</aui:form>
