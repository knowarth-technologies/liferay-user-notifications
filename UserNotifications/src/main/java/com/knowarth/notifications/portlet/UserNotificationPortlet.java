package com.knowarth.notifications.portlet;

import com.liferay.portal.kernel.dao.search.SearchContainer;
import com.liferay.portal.kernel.model.UserNotificationEvent;
import com.liferay.portal.kernel.portlet.PortletURLFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.service.UserNotificationEventLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.WebKeys;

import java.io.IOException;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.PortletRequest;
import javax.portlet.PortletURL;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;

/**
 * @author vishal.shah
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.instanceable=false",
		"javax.portlet.display-name=User Notification Portlet",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class UserNotificationPortlet extends MVCPortlet {

	@Override
	public void render(RenderRequest renderRequest, RenderResponse renderResponse)
			throws IOException, PortletException {
		// TODO Auto-generated method stub
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		PortletURL iteratorURL=PortletURLFactoryUtil.create(renderRequest, themeDisplay.getPortletDisplay().getId(), themeDisplay.getPlid(), PortletRequest.RENDER_PHASE);
		SearchContainer<UserNotificationEvent> searchContainer=null;
		searchContainer=new SearchContainer<UserNotificationEvent>(renderRequest,null,null,SearchContainer.DEFAULT_CUR_PARAM,10,iteratorURL,null,StringPool.BLANK);
		searchContainer.setIteratorURL(iteratorURL);
		renderRequest.setAttribute("searchContainer",searchContainer);
		super.render(renderRequest, renderResponse);
	}

	@Override
	public void serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws IOException, PortletException {
		// TODO Auto-generated method stub
		
		String actionName = ParamUtil.getString(
				resourceRequest,"callfor");
		try {
		if (actionName.equals("markAsRead")) {
			
				markAsRead(resourceRequest, resourceResponse);
			
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		super.serveResource(resourceRequest, resourceResponse);
	}


	
	public void markAsRead(
			ResourceRequest resourceRequest, ResourceResponse resourceResponse)
		throws Exception {

		long userNotificationEventId = ParamUtil.getLong(
				resourceRequest, "userNotificationEventId");
		updateArchived(userNotificationEventId);


	}
	
	protected void updateArchived(long userNotificationEventId)
			throws Exception {

		UserNotificationEvent userNotificationEvent = UserNotificationEventLocalServiceUtil.fetchUserNotificationEvent(userNotificationEventId);
			if (userNotificationEvent == null) {
				return;
			}

			userNotificationEvent.setArchived(true);

			UserNotificationEventLocalServiceUtil.updateUserNotificationEvent(
				userNotificationEvent);
		}
	
}