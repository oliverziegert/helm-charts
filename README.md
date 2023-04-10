## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add oliverziegert https://oliverziegert.github.io/helm-charts

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
oliverziegert` to see the charts.

To install the cert-manager-webhook-hostingde chart:

    helm install my-cert-manager-webhook-hostingde oliverziegert/cert-manager-webhook-hostingde

To uninstall the chart:

    helm delete my-cert-manager-webhook-hostingde