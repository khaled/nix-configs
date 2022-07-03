export PATH=~/bin:$PATH
export EDITOR="code --wait"
# export AWS_ACC_ID ="FIXME"

# kc alias is for completion, function for scripts
function kc() { kubectl "$@" }
function wdf() { watch -d -n 1 "$@" }

source <(kubectl completion zsh)

### git
grbu() {(
  set -Exeuo pipefail
  # $1 - upstream branch name
  git fetch upstream
  git rebase upstream/$1
)}

make-pr() {(
  set -Exeuo pipefail
  # $1 - upstream branch name
  grbu $1
  git push --force
  gh pr create --fill
  gh pr view
)}

### k8s clusters - manage kube contexts
uc() {
  mkdir -p ~/.kube/custom
  touch ~/.kube/custom/current
  if [ "$1" = 'default' ]; then
    name=~/.kube/config
  else
    name=~/.kube/custom/$1.kubeconfig
  fi
  if [ -f $name ]; then
    echo "Setting config to $name"
    echo $name > ~/.kube/custom/current
  fi
  export KUBECONFIG=$(cat ~/.kube/custom/current)
  # xargs has the side effect of trimming a string
  export KUBE_CONTEXT=$(kubectl config view | grep "current-context:" | cut -d : -f 2 | xargs)
  echo "KUBECONFIG is $KUBECONFIG"
  echo "KUBE_CONTEXT is $KUBE_CONTEXT"
}

lc() {
  ls -al ~/.kube/custom/
}

exportChart() {(
  set -Exeuo pipefail
  # $1 - chart name, without helm/ prefix
  dest=$(mktemp -d)
  aws ecr get-login-password --region us-west-2 | HELM_EXPERIMENTAL_OCI=1 helm registry login --username AWS --password-stdin ${AWS_ACC_ID }.dkr.ecr.us-west-2.amazonaws.com
  HELM_EXPERIMENTAL_OCI=1 helm chart pull ${AWS_ACC_ID }.dkr.ecr.us-west-2.amazonaws.com/helm/"$1"
  HELM_EXPERIMENTAL_OCI=1 helm chart export ${AWS_ACC_ID }.dkr.ecr.us-west-2.amazonaws.com/helm/"$1" -d $dest
  echo "Chart is available in ${dest}"
  code $dest
)}

listImageVersions() {
  AWS_PAGER='' aws ecr list-images --repository-name $1 --registry-id ${AWS_ACC_ID } | jq ".imageIds[].imageTag" | sort
}

writeKubeConfig() {(
  set -Exeuo pipefail
  local cname="$1"  # cluster name
  local fname="${2:-$cname}"  # file name
  local outpath=~/.kube/custom/"$fname".kubeconfig
  eksctl utils write-kubeconfig --kubeconfig "$outpath" --cluster "$cname"
  rm "$outpath".eksctl.lock
  echo "wrote to $outpath"
)}

kcAll() {
  kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n $1
}

kcDeleteNs() {(
  set -Exeuo pipefail
  local ns="$1"
  kubectl delete msr --all --namespace "$ns"
  kubectl delete servicediscovery --all --namespace "$ns"
  kubectl delete namespace "$ns"
)}

kcForceDeleteNs() {
  open "https://stackoverflow.com/questions/55853312/how-to-force-delete-a-kubernetes-namespace"
}

kcDeleteFinalizers() {
  # $1 is object type
  # $2 is namespace
  # there's probably a more efficient way, using patch
  # kubectl get $1 -n $2 -o name | xargs -n 1 kubectl get -n $2 -o json | jq '.metadata.finalizers = null' | kubectl apply -n $2 -f  -
  kubectl get $1 -n $2 -o name | xargs -n 1 kubectl patch -n $2 -p '{"metadata":{"finalizers":null}}' --type=merge
}

ch() {
  curl cheat.sh/$1
}
uc
