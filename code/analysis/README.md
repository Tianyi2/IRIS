# Static Analyses

This folder contains all downstream static analyses that consume the **IR** and/or the **dependency graph** produced from Infrastructure as Code (IaC) templates. The analyses are implemented across three modules: `condition_analysis.py`, `dependency_graph_analysis.py`, and `security_analysis.py`. Below are definitions for each of the **13 analyses**, describing what each implementation is trying to detect.

---

## Condition analyses (`condition_analysis.py`)

These analyses use the IR and an SMT solver (Z3) to reason about conditions and their effect on provisioning.

### 1. Always true conditions

**Definition:** A conditional expression that, under the parameter constraints defined in the template, can evaluate to true but never to false. The condition is effectively constant and does not vary with parameter values.

### 2. Always false conditions

**Definition:** A conditional expression that, under the parameter constraints defined in the template, can evaluate to false but never to true. The condition is effectively constant and will always prevent the guarded branch from being taken.

<!-- ### 3. Invalid conditions

**Definition:** A conditional expression that, under the parameter constraints, can be neither satisfied nor unsatisfied—i.e., the condition and the parameter constraints are logically inconsistent (no satisfying assignment exists for either the condition or its negation). -->

### 3. Dead resources

**Definition:** A resource that is defined in the template but will never be provisioned because it is gated by a condition that is always false. The implementation identifies resources whose `condition` argument (or equivalent) references an always-false condition.

---

## Dependency-graph analyses (`dependency_graph_analysis.py`)

These analyses use the dependency graph (and optionally the IR) to detect unused elements, missing sourcing, and structural issues in the template.

### 4. Unused parameters

**Definition:** A parameter is defined in the template but is not referenced by any other node in the dependency graph (it has no outgoing edges). The parameter is therefore never used within the IaC template.

### 5. Unused conditions

**Definition:** A condition is defined in the template but is never referenced by any other node (it has no outgoing edges), and it is not a rule condition (e.g. not governing parameter constraints). The logic condition exists but is never evaluated or used.

### 6. No sourced outputs

**Definition:** An output variable is defined but its value is not derived from any parameter, condition, or resource—i.e. the output node’s only incoming edge in the dependency graph is from the root node. The output is effectively hardcoded or not connected to a meaningful source.

### 7. No sourced conditions

**Definition:** A conditional statement depends only on the root node in the dependency graph (no incoming edges from parameters or resources) and is not a rule condition. The condition therefore relies on values that are not dynamically sourced, effectively making it hardcoded or constant.

### 8. Circular dependencies

**Definition:** Resources and/or other nodes form a cycle in the dependency graph: there is a path from node A to node B and a path from node B back to node A. Such cycles can prevent correct provisioning order and lead to deployment failures.

### 9. Cascading provision failure

**Definition:** A resource that depends on another resource that is conditionally provisioned is not itself protected by the same condition (or a safely equivalent one). If the condition is false, the parent resource is not created, and the dependent resource fails to provision as well—one resource’s failure causes a chain reaction of failures.

---

## Security analyses (`security_analysis.py`)

These analyses use the IR to detect security-related issues in parameters and resource properties.

### 10. Hard-coded secrets

**Definition:** Sensitive information such as passwords, keys, or other secret-bearing values is stored as literal values in the IaC template. The implementation detects: (1) resource properties that are known to hold secrets (e.g. password, secret key) and have a literal value with no parameter or secret-manager reference, (2) parameters whose names suggest they hold secrets and have a literal default value, and (3) parameters which set to be sensitive.

### 11. Unrestricted IP addresses

**Definition:** A resource property that represents a bind or listen address (e.g. for security groups or network interfaces) is set to an unrestricted value such as `0.0.0.0` or `0.0.0.0/0`, which can expose the resource to all networks. 

### 12. Unprotected secrets

**Definition:** A parameter whose name suggests it holds secret data (e.g. password, token) is not marked as sensitive or masked (e.g. NoEcho, secureString type, or equivalent in the IR). Such parameters may have their values exposed in metadata, outputs, or logs at and after deployment.

# Analysis Summary
| # | Category | Name | Related CWE | Definition |
| :-------- | :-------- | :-------- | :-------- | :-------- | 
| 1 | Code Quality | Always True Condition | CWE-570 | A conditional expression that, under the parameter constraints defined in the template, can evaluate to true but never to false. The condition is effectively constant and does not vary with parameter values.