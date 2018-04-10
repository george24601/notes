public class JsonWebTokenAuthenticationFilter extends RequestHeaderAuthenticationFilter {
 
	//At this point, the header has been converted into a Spring Authentication object in the form of a PreAuthenticatedAuthenticationToken.
    public JsonWebTokenAuthenticationFilter() {
        // Don't throw exceptions if the header is missing
        this.setExceptionIfHeaderMissing(false);
 
        // This is the request header it will look for
        this.setPrincipalRequestHeader("Authorization");
    }
 
    @Override
    @Autowired
    public void setAuthenticationManager(AuthenticationManager authenticationManager) {
        super.setAuthenticationManager(authenticationManager);
    }
}
