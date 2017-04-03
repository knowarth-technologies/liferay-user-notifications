<%@page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@ include file="init.jsp" %>

 <link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet"> 
 <link href="<%=request.getContextPath()%>/css/custom.css" rel="stylesheet"> 
 <script src="<%=request.getContextPath()%>/js/custom.js"></script>
<%
DateFormat dateFormatDateTime = new SimpleDateFormat("MM-dd-yyyy HH:mm:ss");
%>

<portlet:resourceURL var="resourceURL">
	<portlet:param name="callfor" value="markAsRead"/>
</portlet:resourceURL>

<c:if test="<%=themeDisplay.isSignedIn() %>">
<input name="portletResourceURL" id="portletResourceURL" type="hidden" value="${resourceURL}" />
<input name="portletNameSpace" id="portletNameSpace" type="hidden" value="<portlet:namespace/>" />
	<div class="row" id="portlet-row" style="background: #365d9e !important;">
		<div class="notify-count pull-left" id="redirectDiv"> 
			<!-- <a class="btn btn-link" href="/web/guest/notification"> -->
				<i class="icon-bell" aria-hidden="true"></i>
				<span class="sticker sticker-circle sticker-sm sticker-danger eventCounts"><%=UserNotificationEventLocalServiceUtil.getArchivedUserNotificationEventsCount(themeDisplay.getUserId(),false, false)%></span>
			<!-- </a> -->
		</div>	
		
		<div class="btn-group pull-right">
			<a class="btn btn-link btn-profile dropdown-toggle" data-toggle="dropdown" href="#">
				<span>
					<c:choose>
						<c:when test='<%=user.getPortraitId() == 0 %>'>
							<%-- <div class="user-icon-color-4 user-icon user-icon-default">
								<span> <%=String.valueOf(user.getFirstName().charAt(0)).toUpperCase().concat(String.valueOf(user.getLastName().charAt(0)).toUpperCase()) %> </span>
							</div> --%>
						</c:when>
						<c:otherwise>
							<div class="aspect-ratio-bg-cover user-icon" style="background-image:url(<%= user.getPortraitURL(themeDisplay) %>)"> </div>
						</c:otherwise>
					</c:choose>
				</span>
				<i class="icon-chevron-down" aria-hidden="true"></i>
			</a>
			<ul class="dropdown-menu profile-dropdown">
				<li>
					<a class="btn-profile" data-redirect="<%=PortalUtil.isLoginRedirectRequired(request) %>" href='<%=HtmlUtil.escape(themeDisplay.getURLSignOut()) %>' id="sign-out" rel="nofollow">
						<i class="icon-power-off" aria-hidden="true"></i>
						<span> <liferay-ui:message key="sign-out"/></span>
					</a>
				</li>
			</ul>
		</div>
	</div>
	
	<div id="notification-data"  class="scrollportletId" style="display:none;">
		
			<liferay-ui:search-container>
			<liferay-ui:search-container-results>
               <% 
               
              /*  List<UserNotificationEvent> events = UserNotificationEventLocalServiceUtil.getDeliveredUserNotificationEvents(themeDisplay.getUserId(), UserNotificationDeliveryConstants.TYPE_WEBSITE, true,false,searchContainer.getStart(),searchContainer.getEnd()); */
              List<UserNotificationEvent> events = UserNotificationEventLocalServiceUtil.getArchivedUserNotificationEvents(themeDisplay.getUserId(), false, false, searchContainer.getStart(),searchContainer.getEnd());
              /*  int userNotificationEventsCount = UserNotificationEventLocalServiceUtil.getDeliveredUserNotificationEventsCount(themeDisplay.getUserId(), UserNotificationDeliveryConstants.TYPE_WEBSITE, true, false); */
               int userNotificationEventsCount = UserNotificationEventLocalServiceUtil.getArchivedUserNotificationEventsCount(themeDisplay.getUserId(),false, false);
               searchContainer.setResults(events);
               searchContainer.setTotal(userNotificationEventsCount);
               
               
               %>
			   </liferay-ui:search-container-results>
			 
			<liferay-ui:search-container-row
						className="com.liferay.portal.kernel.model.UserNotificationEvent" keyProperty="userNotificationEventId"
						modelVar="userNotificationEvent"
			>
			<%
			UserNotificationFeedEntry userNotificationFeedEntry = UserNotificationManagerUtil.interpret(StringPool.BLANK, userNotificationEvent, ServiceContextFactory.getInstance(request));
			
			JSONObject jsonObject = JSONFactoryUtil.createJSONObject(userNotificationEvent.getPayload());
			
			boolean anonymous = jsonObject.getBoolean("anonymous");
			
			long userNotificationEventUserId = jsonObject.getLong("userId");
			%>
			
			<c:choose>
				<c:when test="<%= !anonymous %>">
					<liferay-ui:search-container-column-user
						showDetails="<%= false %>"
						userId="<%= userNotificationEventUserId %>"
					/>
				</c:when>
				<c:otherwise>
					<liferay-ui:search-container-column-text>
						<liferay-ui:user-portrait userId="<%= 0 %>" />
					</liferay-ui:search-container-column-text>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="<%= userNotificationFeedEntry == null %>">
					<liferay-ui:search-container-column-text colspan="<%= 2 %>">
						<liferay-ui:message key="notification-no-longer-applies" />
					</liferay-ui:search-container-column-text>
				</c:when>
				<c:otherwise>
			
			
				
					<liferay-ui:search-container-column-text colspan="<%= 2 %>" cssClass='<%= "notification_"+ userNotificationEvent.getUserNotificationEventId()  %>'>
					
						
							<div class="body-container">
								<%= userNotificationFeedEntry.getBody() %>
							</div>
			
							  <div class="timestamp">
								<span title="<%= dateFormatDateTime.format(userNotificationEvent.getTimestamp()) %>">
									<%= Time.getRelativeTimeDescription(userNotificationEvent.getTimestamp(), themeDisplay.getLocale(), themeDisplay.getTimeZone(), dateFormatDateTime) %>
								</span>
							</div> 
					</liferay-ui:search-container-column-text>
				</c:otherwise>
			</c:choose>
			<liferay-ui:search-container-column-jsp align="right" path="/notification_actions.jsp" />
			
			</liferay-ui:search-container-row>
			 
			<liferay-ui:search-iterator displayStyle="descriptive" markupView="lexicon" />
			</liferay-ui:search-container>
			<a class="alink" style="float: left;" href="<%=GetterUtil.getString(portletPreferences.getValue("notificationURL", "")) %>">View All Notifications</a>			
		
		</div>
			
</c:if>

