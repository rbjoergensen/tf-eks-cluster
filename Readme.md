# GitHub Repository Template
Template for creating new repositories in my GitHub account. Contains some of the basic files, configuration and pipelines i use across all repositories.
## Documentation
For documentation i use a dispatch trigger to trigger the build and deploy of docs.callofthevoid.dk when there are changes to markdown files in my repositories. This trigger is configured in the docs-update workflow.<br/><br/>
The file ´docs.yml´ contains some of the data for displaying the documentation in a prettier format on the site.
## Versioning
The file gitversion.yml contains the GitVersion configuration i normally used for generating version numbers for applications and there is a basic example of how to use it in the build workflow.