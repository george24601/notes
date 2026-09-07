# Data Mesh: Discovery, Governance, and In-Place Consumption

The useful boundary in a data mesh is not a centralized data store: it is a shared control plane that makes independently owned data products discoverable, interoperable, governable, and safe to consume in place.

## Data-product registry and discovery

Every data product should publish enough metadata for a consumer to evaluate and use it without back-channel discovery:

- owner and ownership relationships;
- technical metadata: tables, topics, events, objects, attributes, types, lengths, indexes, connections, and schemas;
- lineage and downstream relationships;
- sample data where appropriate;
- quality expectations and observed quality results; and
- business glossary terms.

The registry/catalog should be the enterprise-wide index of these products, while a separate discovery interface is usually needed to make the catalog usable. The catalog holds metadata and visibility of sharing relationships—not copies of the data. That distinction keeps the producer's controls effective and lets the organization audit where data is used.

Metadata acquisition should be push-based: domain teams publish metadata through self-service APIs or product templates as part of creating or changing a dataset. This avoids a central onboarding team becoming the bottleneck and keeps ownership information close to the people who understand the product. Metadata and operational metrics can then be surfaced through a workbench such as DataHub.

## Interoperability needs deliberate standards

Domain autonomy does not mean every domain invents incompatible meaning. Centralize the minimum shared contract:

- common metadata fields and event formats;
- schemas and compatibility checks;
- quality-rule conventions and validation capabilities;
- a business glossary / ubiquitous language for fundamental cross-domain concepts; and
- self-service tooling, including policy and encryption primitives.

Inconsistent names and meanings create expensive mappings, incorrect interpretation, and eventually financial or reputational harm. Industry vocabularies (for example, FIBO in finance) can complement local terms. A domain schema repository can publish generated bindings and canonical artifacts, with Buf-style compatibility checks, without taking schema ownership away from domains.

## Quality, access, and privacy

Let producers define data-quality rules in a DSL in their domain repository. Provision validation jobs from those definitions and publish results to an agreed event stream or catalog. Standardize the rule mechanism; keep responsibility for the rules with the producer.

Access should distinguish two policy layers:

- **Subscription policy**: whether a consumer may use a dataset at all.
- **Data policy**: what that consumer may see once subscribed—columns, rows, or even individual values.

Avoid a manual “manager approval for every request” workflow: it produces approval bottlenecks, ambiguous ownership, and long time-to-data. Automate the request, approval, provisioning, logging, and monitoring flow where possible, while preserving producer control.

Prefer in-place consumption over exporting copies. It prevents a control gap when producers tokenize or otherwise protect data, and supports granular enforcement for a consumer's line of business. Attribute-level sensitivity can be encoded in Protobuf annotations; applications can use those annotations to determine encryption requirements. Each entity can retain its own encryption keys and segregated data, while identity roles govern decryption.

## Patterns from implementations

### Saxo

Use a catalog that combines technical metadata, ownership, lineage, and glossary terms. Extract dataset and element definitions from topic/schema files, enrich product templates with ownership, and publish through defined interfaces. The key lesson is to minimize separate metadata onboarding by collecting it during the normal dataset onboarding flow.

### JPMorgan

Product lakes remain physically separate, but an enterprise catalog makes their shared datasets discoverable and exposes lake-to-consumer flows for audit. Consumers query data in place; access can be constrained at column, record, and value levels. A lake may progress from raw to trusted (validated) to refined (transformed), with catalog metadata updated as it is ingested, checked, and curated.

### Fannie Mae

Lines of business publish and maintain their own data products in a centralized catalog. Consumers create a data contract that producers review, then an automated workflow provisions just-in-time, persona-based access and records the activity. The practical target is a discovery-to-subscription flow measured in minutes, not a manual ticket queue.
