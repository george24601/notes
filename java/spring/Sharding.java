public class ShardingContextHolder<T> {

	private static final ThreadLocal shardHolder = new ThreadLocal();

	public static <T> void setShard(T shard) {
		Validate.notNull(shard, "shard can't be null");
		shardHolder.set(shard);
	}

	public static <T> T getShard() {

		return (T) shardHolder.get();

	}

}

public class ShardingTransactionManager implements PlatformTransactionManager {

	private Map<Object, PlatformTransactionManager> proxyTransactionManagers = new HashMap<Object, PlatformTransactionManager>();

	protected PlatformTransactionManager getTargetTransactionManager() {

		Object shard = ShardingContextHolder.getShard();
		Validate.notNull(shard, "shard can't be null");
		return targetTransactionManagers.get(shard);

	}

	public void setProxyTransactionManagers(Map<Object, PlatformTransaction Manager> targetTransactionManagers) {
		this.targetTransactionManagers = targetTransactionManagers;
	}

	public void commit(TransactionStatus status) throws TransactionException {
		getProxyTransactionManager().commit(status);
	}

	public TransactionStatus getTransaction(TransactionDefinition definition) throws TransactionException {
		return getProxyTransactionManager().getTransaction(definition);
	}

	public void rollback(TransactionStatus status) throws TransactionException
	{
		getProxyTransactionManager().rollback(status);
	}

}

@TransactionHint(table = "INVOICE", keyPath = "0.accountId")

public void persistInvoice(Invoice invoice) {

	// Save invoice to DB

	this.createInvoice(invoice);



	for (InvoiceItem invoiceItem : invoice.getItems()) {

		invoiceItem.setInvId(invoice.getId());

		invoiceItemService.createInvoiceItem(invoice.getAccountId(), invoiceItem);

	}



	// Save invoice to cache

	invoiceCacheService.set(invoice.getAccountId(), invoice.getInvPeriodStart().getTime(), invoice.getInvPeriodEnd().getTime(),

			invoice);



	// Update last invoice date to Account

	Account account = new Account();

	account.setId(invoice.getAccountId());

	account.setLstInvDate(invoice.getInvPeriodEnd());

	accountService.updateAccount(account);
}

@Target({ElementType.METHOD})

@Retention(RetentionPolicy.RUNTIME)

@Documented

public @interface TransactionHint {

	String table() default "";



	String keyPath() default "";

}

SimpleSplitJdbcTemplate simpleSplitJdbcTemplate =

(SimpleSplitJdbcTemplate) ReflectionUtil.getFieldValue(field SimpleSplitJdbcTemplate, invocation.getThis());



Method method = invocation.getMethod();

// Convert to th method of implementation class

method = targetClass.getMethod(method.getName(), method.getParameter Types());



TransactionHint[] transactionHints = method.getAnnotationsByType (TransactionHint.class);

if (transactionHints == null || transactionHints.length < 1)

	throw new IllegalArgumentException("The method " + method + " includes illegal transaction hint.");

	TransactionHint transactionHint = transactionHints[0];



	String tableName = transactionHint.table();

	String keyPath = transactionHint.keyPath();



	String[] parts = keyPath.split("\\.");

	int paramIndex = Integer.valueOf(parts[0]);



	Object[] params = invocation.getArguments();

	Object splitKey = params[paramIndex];



	if (parts.length > 1) {

		String[] paths = Arrays.copyOfRange(parts, 1, parts.length);

		splitKey = ReflectionUtil.getFieldValueByPath(splitKey, paths);

	}



SplitNode splitNode = simpleSplitJdbcTemplate.decideSplitNode(tableName, splitKey);

ThreadContextHolder.INST.setContext(splitNode);

public class ThreadContextHolder<T> {

	public static final ThreadContextHolder<SplitNode> INST = new ThreadContextHolder<SplitNode>();



	private ThreadLocal<T> contextHolder = new ThreadLocal<T>();



	public T getContext() {

		return contextHolder.get();

	}



	public void setContext(T context) {

		contextHolder.set(context);

	}

}

public class RoutingTransactionManager implements PlatformTransactionManager {

	protected PlatformTransactionManager getTargetTransactionManager() {

		SplitNode splitNode = ThreadContextHolder.INST.getContext();

		return splitNode.getPlatformTransactionManager();

	}



	public void commit(TransactionStatus status) throws TransactionException {

		getTargetTransactionManager().commit(status);

	}



	public TransactionStatus getTransaction(TransactionDefinition definition) throws TransactionException {

		return getTargetTransactionManager().getTransaction(definition);

	}



	public void rollback(TransactionStatus status) throws TransactionException
	{
		getTargetTransactionManager().rollback(status);

	}
}
