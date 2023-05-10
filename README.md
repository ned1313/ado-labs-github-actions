# Azure DevOps Labs - GitHub Actions with Terraform - Location WestUS

Howdy there! These are the demo files to accompany the [Azure DevOps Lab video GitHub Actions with Terraform.](https://youtu.be/QcBtWX72dRw) This demo includes the following:

* Terraform code to deploy an instance of App Services on Microsoft Azure
* GitHub Actions to manage the deployment of Terraform code

If you'd like to follow along you'll need the following:

* An Azure subscription
* An Azure AD service principal with Contributor permissions
  * Instructions included below to create the service principal
* An Azure storage account and container
  * Instructions included below to create the storage account
* A GitHub account and a forked instance of this repository
* The drive to be awesome!
  * Oh wait, you already ARE **awesome**! Well done.

## Creating the Azure AD Service Principal and Storage Account

Terraform needs credentials to create something on Azure for you. When you're running Terraform locally, you can log into Azure with the Azure CLI and Terraform will glom onto those credentials for authentication and authorization. But now we're running things remotely from a GitHub Actions hosted runner. How do we get that runner credentials? Through environment variables and a service principal. The values for the service principal will be stored in the GitHub secrets for the repository and loaded as environment variables when a hosted runner starts up.

Terraform also needs to store its state data somewhere. By default it does this on your local system, which is fine when your local system is persistent. The hosted runners for GitHub are ephemeral, so kiss that state data goodbye! Instead, we are going to store our state data persistently on an Azure storage account. Since we already have a service principal, we might as well use that for authentication and authorization on the storage account too!

We could configure all of this manually, but that is BORING. And inconsistent, and inefficient, and look I just don't wanna. Let's use Terraform instead!

The code in the `remote_setup` directory will create the following for you:

* Azure storage account and container
* Service principal with Contributor rights
* GitHub secrets in the selected repository

You will need to get a GitHub personal access token (PAT) that Terraform can use for authentication to your GitHub account. Here's a [link showing how to do exactly that](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).

Once you've got your PAT from GitHub, run the following from the root of the repository:

```bash
# Set the GitHub PAT as an environment variable
export GITHUB_TOKEN=PAT_TOKEN_VALUE

# Log into Azure and select a subscription where you will deploy resources
az account login -s SUBSCRIPTION_NAME

# Go into the remote setup directory
cd remote_setup

# Initialize and apply the code
# If you use a different repository name, you'll need to specify -var=github_repository=NAME_OF_YOUR_REPO
terraform init
terraform apply -auto-approve # Because we live on the edge!
```

At this point your GitHub repository is all set for you to kick off a GitHub Action. Actions are triggered by any `push` or `pull_request` event that happens in the repo. Pushing an updated version from your local desktop should trigger it. The Action will do the following:

* All events
  * Pull the repo to the runner
  * Install Terraform
  * Initialize Terraform with remote state

* Pull Requests
  * Generate a plan of the changes
  * Add the results of the plan to the pull request as a comment

* Push on main branch (AKA a merge)
  * Run a Terraform apply with `-auto-approve` to update the target environment

Feel free to mess around with the different events to manipulate the environment.

## Cleanup

When you're done with this experiment, you've got two things to cleanup. The environment deployed by GitHub Actions and the supporting environment deployed from `remote_setup`. Start by either removing the GitHubs actions `terraform.yml` file or deleting the repository. Then delete the resource group  for the Web App using the Azure CLI or Portal.

From the `remote_setup` directory run `terraform destroy` to delete all supporting resources.

And that's it! You've cleaned up.

