# Architecture & System Design

> Architectural patterns, distributed systems trade-offs, authentication protocols, data modeling paradigms, and API design standards.

---

## 📑 Domain Index

### Authentication, Identity & Security
Located in [`auth/`](auth/):
- [`oauth.md`](auth/oauth.md): OAuth 2.0 grant types, token flows, security considerations, and PKCE.
- [`oidc.md`](auth/oidc.md): OpenID Connect identity layer on top of OAuth 2.0, ID tokens, and claims.
- [`jwt.md`](auth/jwt.md): JSON Web Token structure, signature verification, expiration handling, and revocation trade-offs.
- [`cors.md`](auth/cors.md): Cross-Origin Resource Sharing mechanisms, preflight requests, and header security.
- [`digestAccess.txt`](auth/digestAccess.txt): HTTP Digest Authentication mechanics and challenge-response flows.
- [`0.md`](auth/0.md): Core authentication notes and threat model overview.

### System & Data Architecture
- [`data_mesh.md`](data_mesh.md): Domain-driven decentralized data architecture, data as a product, self-serve data infrastructure, and federated computational governance.
- [`star_schema.md`](star_schema.md): Dimensional data modeling, facts vs. dimensions, slow-changing dimensions (SCD), and OLAP optimization.
- [`rest.md`](rest.md): Pragmatic RESTful API design, idempotency, status code conventions, and resource modeling.
- [`sample_api.md`](sample_api.md): Reference API design specifications and interface contracts.
- [`dm.md`](dm.md): Data mapping, domain modeling boundaries, and data pipelines.
- [`learn_code.md`](learn_code.md): Heuristics and mental models for rapidly understanding unfamiliar codebases and system architectures.
- [`syntax.md`](syntax.md): Syntax and DSL design patterns.
- [`misc.md`](misc.md): Miscellaneous architectural trade-off notes.

---

## 💡 Related Notes

- **Concrete Systems**: See real-world system operational configs in [`specific/`](../specific/) (TiDB, Kafka, Vault, Databricks).
- **Decision Heuristics**: Consult [`how_to_use_me/decision_making.md`](../how_to_use_me/decision_making.md) and [`how_to_use_me/technology_philosophy.md`](../how_to_use_me/technology_philosophy.md).
