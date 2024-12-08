# First steps with Terraform


## 01 Basics

Here I show how we can setup a provider and create a simple EC2 instance.

## 02 Variable

Now, we will setup variables files to use it on main file.

https://developer.hashicorp.com/terraform/language/values/variables

## 03 Functions

Terraform's for_each allows you to configure a set of similar resources by iterating over a data structure.

https://developer.hashicorp.com/terraform/tutorials/configuration-language/for-each
https://developer.hashicorp.com/terraform/tutorials/configuration-language/functions

## 04 Modules

Quick example of network module, this modules can make us happy :D.

https://developer.hashicorp.com/terraform/language/modules

## 05 Deploy a dockerized wordpress.

Final example, in this example we create the resources and run the script to configure and run a dockerized application in the EC2 instance created.