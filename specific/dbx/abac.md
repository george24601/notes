Attribute-based access control (ABAC) is a data governance model that provides flexible, scalable, and centralized access control across Databricks.

Account admins on the recipient side must set the Attribute Based Access Control for Delta Sharing toggle to On from Account console Previews to read shared tables secured by ABAC policies. This ensures that the query results are correct. Otherwise, there is a risk that data is not correctly governed.

Create ABAC policies for shared tables and schemas, and catalogs created from a share. Materialized views are supported with limitations. You can't create ABAC policies for shared streaming tables. To configure ABAC policies, see Create and manage attribute-based access control (ABAC) policies.




I agree that doing this for all tables would be a big lift. We should start with just the core tables that ~80% of POCs rely on.
This proposal is important but not urgent. I will collect data points and build a use case doc (target tables, estimated ROI) over time. 
I suspect induced demands here. A low-friction environment will encourage new experimentation and use cases that wouldn't otherwise be attempted.





1. Scope: When we do this, 

2. Priority: I view this as important but not urgent. It’s a strategic enabler for velocity, not a fire to fight this week.

3. The 'Hidden Demand' Dynamic: I suspect the current friction (IaC for POCs) is actually suppressing demand. Usage is low because the barrier to entry is high, not because the need isn't there.

Next Step: I’ll own the homework. I will collect data points and build a focused use case doc (target tables, estimated ROI) over the next few weeks so we can make an informed decision on prioritization later.
