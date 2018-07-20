class ZuulServlet {
	void error(ZuulException e) {
		RequestContext.getCurrentContext().setThrowable(e);
		zuulRunner.error();
	}

	service(ServletRequest, ServletResponse) {
		try {

			try {
				preRoute();
			} catch (ZuulException e) {
				error(e);
				postRoute();
				return;
			}
			try {
				route();
			} catch (ZuulException e) {
				error(e);
				postRoute();
				return;
			}
			try {
				postRoute();
			} catch (ZuulException e) {
				error(e);
				return;
			}
		} catch (Throwable e) {
			error(new ZuulException(e, 500, "UNHANDLED_EXCEPTION_" + e.getClass().getName()));
		}
	}
}

class FilterProcessor {

	void processZuulFilter(){
		try {

			Throwable t = null;

			ZuulFilterResult result = filter.runFilter();
			ExecutionStatus s = result.getStatus();

			switch (s) {
				case FAILED:
					t = result.getException();
					break;

			}
			if (t != null) throw t;
		} catch (Throwable e) {
			if (e instanceof ZuulException) {
				throw (ZuulException) e;
			} else {
				ZuulException ex = new ZuulException(e, "Filter threw Exception", 500, filter.filterType() + ":" + filterName);
				throw ex;
			}
		}

	}
}

class ZuulFilter {
	void runFilter() {
		ZuulFilterResult zr = new ZuulFilterResult();

		try {
			Object res = run();
			zr = new ZuulFilterResult(res, ExecutionStatus.SUCCESS);
		} catch (Throwable e) {
			zr = new ZuulFilterResult(ExecutionStatus.FAILED);
			zr.setException(e);
		}

		return zr;
	}
}


