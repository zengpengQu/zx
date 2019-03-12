package com.taiji.frame.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SessionFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {

	}

	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
		// uri
		String[] notFilter = new String[]{
				"/login.do",
				"/index.do",
				"/save.do",
				"/file/download.do",
				"/loadUserByGN.do",
				"/certifiLogin.do",
				"/loginNoUser.do"

        };    //定义不拦截的请求
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		// uri
		String uri = request.getRequestURI();

		boolean doFilter = true;

		for (String s : notFilter) {
			if (uri.indexOf(s) != -1) {
				doFilter = false;
				break;
			}
		}

		if (doFilter) {
			// session
			Object obj = request.getSession().getAttribute("currentUser");
			if (null == obj) {
                String url=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/index.jsp";
				response.sendRedirect(url);

			} else {
				filterChain.doFilter(request, response);
			}
		} else {
			filterChain.doFilter(request, response);
		}
	}

	@Override
	public void destroy() {

	}
}
