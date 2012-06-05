Feature: Memory
    
    Scenario: Storing Key-Value Data
        Given i have a key "Foo"
        And i have a value "Bar"
        When I store them in Nyx's Memory
        Then i should be able to retrive "Bar" with the key "Foo"
