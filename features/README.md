# Rule Validation using a Definite Clause Grammar

This program aims to support specification of rules in a Domain Specific Language using a Prolog Declarative Clause Grammar.

## Objective
The objective would be that feature rules can be defined in English-like sentences, e.g. `admin_feature: person role equals admin`. The Rule Validator would ensure that that is a valid specification and convert it to a Prolog rule. This rule could then be applied to input data (e.g. in JSON format) and return a dictionary of evaluated rules based on that data.

For instance, given a rule `admin_feature: person role equal admin` and a JSON blob:
```json
{
    "person": {
        "role": "admin",
    }

}
```
We would then return a JSON blob with the evaluated rule:
```json
{
    "admin_feature": true,
}
```
## Current implementation
We currently have an initial Rule Validator that defines a DCG for rules and evaluates lists for correctness. For instance:
```prolog
?- rule_definition(["admin_feature", "person", "role", "equals", "admin"]).
true .

?- rule_definition(["premier_feature", "account", "type", "equals", "premium"]).
true .
```
On the converse, a list that does not follow the conventions will be evaluated as false:
```prolog
?- rule_definition(["bogus_flag", "sentence", "definition", "is", "wrong"]).
false.
```

## Work to be done

### Rule Intake and Translation
We will need to be able to read in sentences such as `admin_feature: person role equals admin` from a file and validate it using our DCG. We will then need to translate validated rule definitions into actual Prolog rules. 

### Data Intake and Evaluation
We will need to be able to input data into our program using JSON format. This will then need to be subject to evaluation by our translated rules. 

### Output
We will finally need to be able to return a response to the inputted data in a similar format.
  

