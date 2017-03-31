/**
 * Copyright 2000-present Liferay, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.knowarth.notifications.portlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.ConfigurationPolicy;


import com.liferay.portal.kernel.portlet.ConfigurationAction;
import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.util.ParamUtil;

@Component(
	configurationPolicy = ConfigurationPolicy.OPTIONAL,
	immediate = true,
	property = {
       
        "javax.portlet.name=com_knowarth_notifications_portlet_UserNotificationPortlet"
    },
    service = ConfigurationAction.class
)
public class NotificationConfiguration extends DefaultConfigurationAction {

	@Override
	public void processAction(PortletConfig portletConfig, ActionRequest actionRequest, ActionResponse actionResponse)
			throws Exception {
		
		String notificationURL = ParamUtil.getString(actionRequest, "notificationURL");
		setPreference(actionRequest, "notificationURL",notificationURL.toString() );
		
		super.processAction(portletConfig, actionRequest, actionResponse);
	}
	@Override
	public void render(RenderRequest request, RenderResponse response) throws PortletException, IOException {
	
			javax.portlet.PortletPreferences preferences=request.getPreferences();
		// TODO Auto-generated method stub
		super.render(request, response);
	}

	/*@Override
	protected void doView(RenderRequest request, RenderResponse response)
		throws IOException, PortletException {

		PrintWriter printWriter = response.getWriter();

		printWriter.print("DS Portlet - Hello World!");
	}*/
}