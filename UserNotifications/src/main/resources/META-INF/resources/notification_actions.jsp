<%@page import="com.liferay.portal.kernel.util.StringPool"%>
<%@page import="com.liferay.portal.kernel.service.SubscriptionLocalServiceUtil"%>
<%@page import="com.liferay.portal.kernel.model.Subscription"%>
<%@page import="com.liferay.portal.kernel.json.JSONFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.json.JSONObject"%>
<%@page import="com.liferay.portal.kernel.model.UserNotificationEvent"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.dao.search.ResultRow"%>
<%@ include file="/init.jsp" %>

<script src="<%=request.getContextPath()%>/js/custom.js"></script>
<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

UserNotificationEvent userNotificationEvent = (UserNotificationEvent)row.getObject();

JSONObject jsonObject = JSONFactoryUtil.createJSONObject(userNotificationEvent.getPayload());

long subscriptionId = jsonObject.getLong("subscriptionId");

if (subscriptionId > 0) {
	Subscription subscription = SubscriptionLocalServiceUtil.fetchSubscription(subscriptionId);

	if (subscription == null) {
		subscriptionId = 0;
	}
}
%>

<liferay-ui:icon-menu direction="left-side" icon="<%= StringPool.BLANK %>" markupView="lexicon" message="<%= StringPool.BLANK %>" showWhenSingleIcon="<%= true %>">

<c:if test="<%= !userNotificationEvent.isArchived() %>">
				<%-- <portlet:actionURL name="markAsRead" var="markAsReadURL">
					<portlet:param name="userNotificationEventId" value="<%= String.valueOf(userNotificationEvent.getUserNotificationEventId()) %>" />
				</portlet:actionURL> --%>
				
				<liferay-ui:icon cssClass="readNotice"  message="mark-as-read" url='<%= "javascript:markAsRead('"+String.valueOf(userNotificationEvent.getUserNotificationEventId())+"');" %>'/>
			</c:if>

</liferay-ui:icon-menu>
