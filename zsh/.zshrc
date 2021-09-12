source $HOME/.profile

# Add custom scripts to Path
PATH=$PATH:$HOME/bin

PATH=$PATH:$HOME/.npm-global/bin

PATH=$PATH:$HOME/go/bin

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


# Antigea nPlugin Manager
source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh

# Touchbar goodies
antigen theme https://github.com/iam4x/zsh-iterm-touchbar

antigen bundle bundler
antigen bundle vi-mode
antigen bundle history-substring-search

antigen bundle docker
antigen bundle docker-compose

antigen bundle srijanshetty/zsh-pandoc-completion

antigen bundle wfxr/forgit
antigen bundle git

antigen bundle soimort/translate-shell

# Colorful stuff
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

source $HOME/.zsh_custom/themes/lnclt.zsh-theme

# Autocorrect
if ( type thefuck &> /dev/null ); then
  eval $(thefuck --alias)
fi

# Fix xon/xoff flow control
stty -ixon

# Functions
python-init() {
  # Init python venv in current dir if no argument given
  projectPath=${PWD##*/}

  if [ -n "$1" ]
  then
    echo "$1"
    export project="$1"
    mkdir "$1"
  else
    export project=${PWD##*/}
  fi

  export projectPath="./${project}"

  # Create .venv folder with project folder name as prompt
  python -m venv "$projectPath/.venv" --prompt "$project"
  source "${projectPath}/.venv/bin/activate"

  # Activate venv and install kernelspec for jupyter
  pip install ipykernel
  python -m ipykernel install --user --name "$project"
  pip install jupyter
}

source <(kubectl completion zsh)
alias k=kubectl
# complete -F __start_kubectl k

autoload -U +X bashcompinit && bashcompinit
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tibor.pilz/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/tibor.pilz/google-cloud-sdk/path.zsh.inc'; fi

# Activate venv and instal kernelspec for jupyter
# pip install ipykernel
# python -m ipykernel install --user --name "$project"
# pip install jupyter
# }
export TAICHI_NUM_THREADS=8
export TAICHI_REPO_DIR=/home/tibor/Code/taichi
export PYTHONPATH=$TAICHI_REPO_DIR/python/:$PYTHONPATH
export PATH=$TAICHI_REPO_DIR/bin/:$PATH
export PATH="/usr/local/sbin:$PATH"

alias k=kubectl
export DRONE_SERVER=https://drone.tibor.host
export DRONE_TOKEN=XOUnEfroPCEQfOUTiuFxFworBRUqK2vj
#compdef _tkn tkn




function _tkn {
  local -a commands

  _arguments -C \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "clustertask:Manage clustertasks"
      "clustertriggerbinding:Manage clustertriggerbindings"
      "completion:Prints shell completion scripts"
      "condition:Manage conditions"
      "eventlistener:Manage eventlisteners"
      "help:Help about any command"
      "pipeline:Manage pipelines"
      "pipelinerun:Manage pipelineruns"
      "resource:Manage pipeline resources"
      "task:Manage tasks"
      "taskrun:Manage taskruns"
      "triggerbinding:Manage triggerbindings"
      "triggertemplate:Manage triggertemplates"
      "version:Prints version information"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  clustertask|clustertasks|ct)
    _tkn_clustertask
    ;;
  clustertriggerbinding|clustertriggerbindings|ctb)
    _tkn_clustertriggerbinding
    ;;
  completion)
    _tkn_completion
    ;;
  condition|cond|conditions)
    _tkn_condition
    ;;
  eventlistener|el|eventlisteners)
    _tkn_eventlistener
    ;;
  help)
    _tkn_help
    ;;
  pipeline|p|pipelines)
    _tkn_pipeline
    ;;
  pipelinerun|pipelineruns|pr)
    _tkn_pipelinerun
    ;;
  resource|res|resources)
    _tkn_resource
    ;;
  task|t|tasks)
    _tkn_task
    ;;
  taskrun|taskruns|tr)
    _tkn_taskrun
    ;;
  triggerbinding|tb|triggerbindings)
    _tkn_triggerbinding
    ;;
  triggertemplate|triggertemplates|tt)
    _tkn_triggertemplate
    ;;
  version)
    _tkn_version
    ;;
  esac
}


function _tkn_clustertask {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "delete:Delete clustertask resources in a cluster"
      "describe:Describes a clustertask"
      "list:Lists clustertasks in a namespace"
      "start:Start clustertasks"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  delete|rm)
    _tkn_clustertask_delete
    ;;
  describe|desc)
    _tkn_clustertask_describe
    ;;
  list|ls)
    _tkn_clustertask_list
    ;;
  start)
    _tkn_clustertask_start
    ;;
  esac
}

function _tkn_clustertask_delete {
  _arguments \
    '--all[Delete all clustertasks (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_clustertasks'
}

function _tkn_clustertask_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_clustertasks'
}

function _tkn_clustertask_list {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_clustertask_start {
  _arguments \
    '--dry-run[preview taskrun without running it]' \
    '(*-i *--inputresource)'{\*-i,\*--inputresource}'[pass the input resource name and ref as name=ref]:()' \
    '(*-l *--labels)'{\*-l,\*--labels}'[pass labels as label=value.]:()' \
    '(-L --last)'{-L,--last}'[re-run the clustertask using last taskrun values]' \
    '--output[format of taskrun dry-run (yaml or json)]:()' \
    '(*-o *--outputresource)'{\*-o,\*--outputresource}'[pass the output resource name and ref as name=ref]:()' \
    '(*-p *--param)'{\*-p,\*--param}'[pass the param as key=value for string type, or key=value1,value2,... for array type]:()' \
    '(-s --serviceaccount)'{-s,--serviceaccount}'[pass the serviceaccount name]: :__kubectl_get_serviceaccount' \
    '--showlog[show logs right after starting the clustertask]' \
    '(-t --timeout)'{-t,--timeout}'[timeout for taskrun in seconds]:()' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_clustertask'
}


function _tkn_clustertriggerbinding {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "delete:Delete clustertriggerbindings"
      "describe:Describes a clustertriggerbinding"
      "list:Lists clustertriggerbindings in a namespace"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  delete|rm)
    _tkn_clustertriggerbinding_delete
    ;;
  describe|desc)
    _tkn_clustertriggerbinding_describe
    ;;
  list|ls)
    _tkn_clustertriggerbinding_list
    ;;
  esac
}

function _tkn_clustertriggerbinding_delete {
  _arguments \
    '--all[Delete all ClusterTriggerBindings (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_clustertriggerbinding'
}

function _tkn_clustertriggerbinding_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_clustertriggerbindings'
}

function _tkn_clustertriggerbinding_list {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_completion {
  _arguments \
    '(-h --help)'{-h,--help}'[help for completion]' \
    '1: :("bash" "zsh")'
}


function _tkn_condition {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "delete:Delete a condition in a namespace"
      "describe:Describe Conditions in a namespace"
      "list:Lists conditions in a namespace"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  delete|rm)
    _tkn_condition_delete
    ;;
  describe|desc)
    _tkn_condition_describe
    ;;
  list|ls)
    _tkn_condition_list
    ;;
  esac
}

function _tkn_condition_delete {
  _arguments \
    '--all[Delete all Conditions in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_condition'
}

function _tkn_condition_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_condition'
}

function _tkn_condition_list {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}


function _tkn_eventlistener {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "delete:Delete EventListeners in a namespace"
      "describe:Describe EventListener in a namespace"
      "list:Lists eventlisteners in a namespace"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  delete|rm)
    _tkn_eventlistener_delete
    ;;
  describe|desc)
    _tkn_eventlistener_describe
    ;;
  list|ls)
    _tkn_eventlistener_list
    ;;
  esac
}

function _tkn_eventlistener_delete {
  _arguments \
    '--all[Delete all EventListeners in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_eventlistener'
}

function _tkn_eventlistener_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_eventlistener'
}

function _tkn_eventlistener_list {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_help {
  _arguments
}


function _tkn_pipeline {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "create:Create a pipeline in a namespace"
      "delete:Delete pipelines in a namespace"
      "describe:Describes a pipeline in a namespace"
      "list:Lists pipelines in a namespace"
      "logs:Show pipeline logs"
      "start:Start pipelines"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  create)
    _tkn_pipeline_create
    ;;
  delete|rm)
    _tkn_pipeline_delete
    ;;
  describe|desc)
    _tkn_pipeline_describe
    ;;
  list|ls)
    _tkn_pipeline_list
    ;;
  logs)
    _tkn_pipeline_logs
    ;;
  start)
    _tkn_pipeline_start
    ;;
  esac
}

function _tkn_pipeline_create {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --from)'{-f,--from}'[local or remote filename to use to create the pipeline]:()' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_pipeline_delete {
  _arguments \
    '--all[Delete all Pipelines in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--prs[Whether to delete pipeline(s) and related resources (pipelineruns) (default: false)]' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipeline'
}

function _tkn_pipeline_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipeline'
}

function _tkn_pipeline_list {
  _arguments \
    '(-A --all-namespaces)'{-A,--all-namespaces}'[list pipelines from all namespaces]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '--no-headers[do not print column headers with output (default print column headers with output)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_pipeline_logs {
  _arguments \
    '(-a --all)'{-a,--all}'[show all logs including init steps injected by tekton]' \
    '(-f --follow)'{-f,--follow}'[stream live logs]' \
    '(-L --last)'{-L,--last}'[show logs for last run]' \
    '--limit[lists number of pipelineruns]:()' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipeline'
}

function _tkn_pipeline_start {
  _arguments \
    '--dry-run[preview pipelinerun without running it]' \
    '(-f --filename)'{-f,--filename}'[local or remote file name containing a pipeline definition to start a pipelinerun]:()' \
    '(*-l *--labels)'{\*-l,\*--labels}'[pass labels as label=value.]:()' \
    '(-L --last)'{-L,--last}'[re-run the pipeline using last pipelinerun values]' \
    '--output[format of pipelinerun dry-run (yaml or json)]:()' \
    '(*-p *--param)'{\*-p,\*--param}'[pass the param as key=value for string type, or key=value1,value2,... for array type]:()' \
    '--prefix-name[specify a prefix for the pipelinerun name (must be lowercase alphanumeric characters)]:()' \
    '(*-r *--resource)'{\*-r,\*--resource}'[pass the resource name and ref as name=ref]:()' \
    '(-s --serviceaccount)'{-s,--serviceaccount}'[pass the serviceaccount name]: :__kubectl_get_serviceaccount' \
    '--showlog[show logs right after starting the pipeline]' \
    '*--task-serviceaccount[pass the service account corresponding to the task]: :__kubectl_get_serviceaccount' \
    '--timeout[timeout for pipelinerun]:()' \
    '--use-param-defaults[use default parameter values without prompting for input]' \
    '--use-pipelinerun[use this pipelinerun values to re-run the pipeline. ]: :__tkn_get_pipelinerun' \
    '(*-w *--workspace)'{\*-w,\*--workspace}'[pass the workspace.]:()' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipeline'
}


function _tkn_pipelinerun {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "cancel:Cancel a PipelineRun in a namespace"
      "delete:Delete pipelineruns in a namespace"
      "describe:Describe a pipelinerun in a namespace"
      "list:Lists pipelineruns in a namespace"
      "logs:Show the logs of PipelineRun"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  cancel)
    _tkn_pipelinerun_cancel
    ;;
  delete|rm)
    _tkn_pipelinerun_delete
    ;;
  describe|desc)
    _tkn_pipelinerun_describe
    ;;
  list|ls)
    _tkn_pipelinerun_list
    ;;
  logs)
    _tkn_pipelinerun_logs
    ;;
  esac
}

function _tkn_pipelinerun_cancel {
  _arguments \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipelinerun'
}

function _tkn_pipelinerun_delete {
  _arguments \
    '--all[Delete all pipelineruns in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '--keep[Keep n most recent number of pipelineruns]:()' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '(-p --pipeline)'{-p,--pipeline}'[The name of a pipeline whose pipelineruns should be deleted (does not delete the pipeline)]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipelinerun'
}

function _tkn_pipelinerun_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipelinerun'
}

function _tkn_pipelinerun_list {
  _arguments \
    '(-A --all-namespaces)'{-A,--all-namespaces}'[list pipelineruns from all namespaces]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '--label[A selector (label query) to filter on, supports '\''='\'', '\''=='\'', and '\''!='\'']:()' \
    '--limit[limit pipelineruns listed (default: return all pipelineruns)]:()' \
    '--no-headers[do not print column headers with output (default print column headers with output)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--reverse[list pipelineruns in reverse order]' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_pipelinerun_logs {
  _arguments \
    '(-a --all)'{-a,--all}'[show all logs including init steps injected by tekton]' \
    '(-f --follow)'{-f,--follow}'[stream live logs]' \
    '(-F --fzf)'{-F,--fzf}'[use fzf to select a pipelinerun]' \
    '(-L --last)'{-L,--last}'[show logs for last pipelinerun]' \
    '--limit[lists number of pipelineruns]:()' \
    '(*-t *--task)'{\*-t,\*--task}'[show logs for mentioned tasks only]:()' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipelinerun'
}


function _tkn_resource {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "create:Create a pipeline resource in a namespace"
      "delete:Delete pipeline resources in a namespace"
      "describe:Describes a pipeline resource in a namespace"
      "list:Lists pipeline resources in a namespace"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  create)
    _tkn_resource_create
    ;;
  delete|rm)
    _tkn_resource_delete
    ;;
  describe|desc)
    _tkn_resource_describe
    ;;
  list|ls)
    _tkn_resource_list
    ;;
  esac
}

function _tkn_resource_create {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_resource_delete {
  _arguments \
    '--all[Delete all PipelineResources in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipelineresource'
}

function _tkn_resource_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_pipelineresource'
}

function _tkn_resource_list {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-t --type)'{-t,--type}'[Pipeline resource type]:()' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}


function _tkn_task {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "create:Create a task in a namespace"
      "delete:Delete task resources in a namespace"
      "describe:Describes a task in a namespace"
      "list:Lists tasks in a namespace"
      "logs:Show task logs"
      "start:Start tasks"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  create)
    _tkn_task_create
    ;;
  delete|rm)
    _tkn_task_delete
    ;;
  describe|desc)
    _tkn_task_describe
    ;;
  list|ls)
    _tkn_task_list
    ;;
  logs)
    _tkn_task_logs
    ;;
  start)
    _tkn_task_start
    ;;
  esac
}

function _tkn_task_create {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --from)'{-f,--from}'[local or remote filename to use to create the task]:()' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_task_delete {
  _arguments \
    '--all[Delete all Tasks in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '--trs[Whether to delete Task(s) and related resources (TaskRuns) (default: false)]' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_task'
}

function _tkn_task_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_task'
}

function _tkn_task_list {
  _arguments \
    '(-A --all-namespaces)'{-A,--all-namespaces}'[list tasks from all namespaces]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '--no-headers[do not print column headers with output (default print column headers with output)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_task_logs {
  _arguments \
    '(-a --all)'{-a,--all}'[show all logs including init steps injected by tekton]' \
    '(-f --follow)'{-f,--follow}'[stream live logs]' \
    '(-L --last)'{-L,--last}'[show logs for last taskrun]' \
    '--limit[lists number of taskruns]:()' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_task'
}

function _tkn_task_start {
  _arguments \
    '--dry-run[preview taskrun without running it]' \
    '(-f --filename)'{-f,--filename}'[local or remote file name containing a task definition to start a taskrun]:()' \
    '(*-i *--inputresource)'{\*-i,\*--inputresource}'[pass the input resource name and ref as name=ref]:()' \
    '(*-l *--labels)'{\*-l,\*--labels}'[pass labels as label=value.]:()' \
    '(-L --last)'{-L,--last}'[re-run the task using last taskrun values]' \
    '--output[format of taskrun dry-run (yaml or json)]:()' \
    '(*-o *--outputresource)'{\*-o,\*--outputresource}'[pass the output resource name and ref as name=ref]:()' \
    '(*-p *--param)'{\*-p,\*--param}'[pass the param as key=value for string type, or key=value1,value2,... for array type]:()' \
    '--prefix-name[specify a prefix for the taskrun name (must be lowercase alphanumeric characters)]:()' \
    '(-s --serviceaccount)'{-s,--serviceaccount}'[pass the serviceaccount name]: :__kubectl_get_serviceaccount' \
    '--showlog[show logs right after starting the task]' \
    '--timeout[timeout for taskrun]:()' \
    '--use-taskrun[specify a taskrun name to use its values to re-run the taskrun]: :__tkn_get_taskrun' \
    '(*-w *--workspace)'{\*-w,\*--workspace}'[pass the workspace.]:()' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_task'
}


function _tkn_taskrun {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "cancel:Cancel a TaskRun in a namespace"
      "delete:Delete taskruns in a namespace"
      "describe:Describe a taskrun in a namespace"
      "list:Lists TaskRuns in a namespace"
      "logs:Show taskruns logs"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  cancel)
    _tkn_taskrun_cancel
    ;;
  delete|rm)
    _tkn_taskrun_delete
    ;;
  describe|desc)
    _tkn_taskrun_describe
    ;;
  list|ls)
    _tkn_taskrun_list
    ;;
  logs)
    _tkn_taskrun_logs
    ;;
  esac
}

function _tkn_taskrun_cancel {
  _arguments \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_taskrun'
}

function _tkn_taskrun_delete {
  _arguments \
    '--all[Delete all taskruns in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '--keep[Keep n most recent number of taskruns]:()' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '(-t --task)'{-t,--task}'[The name of a task whose taskruns should be deleted (does not delete the task)]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_taskrun'
}

function _tkn_taskrun_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_taskrun'
}

function _tkn_taskrun_list {
  _arguments \
    '(-A --all-namespaces)'{-A,--all-namespaces}'[list taskruns from all namespaces]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '--label[A selector (label query) to filter on, supports '\''='\'', '\''=='\'', and '\''!='\'']:()' \
    '--limit[limit taskruns listed (default: return all taskruns)]:()' \
    '--no-headers[do not print column headers with output (default print column headers with output)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--reverse[list taskruns in reverse order]' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_taskrun_logs {
  _arguments \
    '(-a --all)'{-a,--all}'[show all logs including init steps injected by tekton]' \
    '(-f --follow)'{-f,--follow}'[stream live logs]' \
    '(-F --fzf)'{-F,--fzf}'[use fzf to select a taskrun]' \
    '(-L --last)'{-L,--last}'[show logs for last taskrun]' \
    '--limit[lists number of taskruns]:()' \
    '(*-s *--step)'{\*-s,\*--step}'[show logs for mentioned steps only]:()' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_taskrun'
}


function _tkn_triggerbinding {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "delete:Delete triggerbindings in a namespace"
      "describe:Describes a triggerbinding in a namespace"
      "list:Lists triggerbindings in a namespace"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  delete|rm)
    _tkn_triggerbinding_delete
    ;;
  describe|desc)
    _tkn_triggerbinding_describe
    ;;
  list|ls)
    _tkn_triggerbinding_list
    ;;
  esac
}

function _tkn_triggerbinding_delete {
  _arguments \
    '--all[Delete all TriggerBindings in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_triggerbinding'
}

function _tkn_triggerbinding_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_triggerbindings'
}

function _tkn_triggerbinding_list {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}


function _tkn_triggertemplate {
  local -a commands

  _arguments -C \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    "1: :->cmnds" \
    "*::arg:->args"

  case $state in
  cmnds)
    commands=(
      "delete:Delete triggertemplates in a namespace"
      "describe:Describes a triggertemplate in a namespace"
      "list:Lists triggertemplates in a namespace"
    )
    _describe "command" commands
    ;;
  esac

  case "$words[1]" in
  delete|rm)
    _tkn_triggertemplate_delete
    ;;
  describe|desc)
    _tkn_triggertemplate_describe
    ;;
  list|ls)
    _tkn_triggertemplate_list
    ;;
  esac
}

function _tkn_triggertemplate_delete {
  _arguments \
    '--all[Delete all TriggerTemplates in a namespace (default: false)]' \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-f --force)'{-f,--force}'[Whether to force deletion (default: false)]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_triggertemplate'
}

function _tkn_triggertemplate_describe {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]' \
    '1: :__tkn_get_triggertemplate'
}

function _tkn_triggertemplate_list {
  _arguments \
    '--allow-missing-template-keys[If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to golang and jsonpath output formats.]' \
    '(-o --output)'{-o,--output}'[Output format. One of: json|yaml|name|go-template|go-template-file|template|templatefile|jsonpath|jsonpath-file.]:()' \
    '--template[Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format is golang templates \[http://golang.org/pkg/text/template/#pkg-overview\].]:filename:_files' \
    '(-c --context)'{-c,--context}'[name of the kubeconfig context to use (default: kubectl config current-context)]:()' \
    '(-k --kubeconfig)'{-k,--kubeconfig}'[kubectl config file (default: $HOME/.kube/config)]: :_filedir' \
    '(-n --namespace)'{-n,--namespace}'[namespace to use (default: from $KUBECONFIG)]: :__kubectl_get_namespace' \
    '(-C --nocolour)'{-C,--nocolour}'[disable colouring (default: false)]'
}

function _tkn_version {
  _arguments \
    '(-c --check)'{-c,--check}'[check if a newer version is available]'
}


# Custom function for Completions
function __tkn_get_object() {
    local type=$1
    local util=$2
    local template begin tkn_out
    template="{{ range .items  }}{{ .metadata.name }} {{ end }}"

    if [[ ${util} == "kubectl" ]];then
        tkn_out=($(kubectl get ${type} -o template --template="${template}" 2>/dev/null))
    elif [[ ${util} == "tkn" ]];then
        tkn_out=($(tkn ${type} ls -o template --template="${template}" 2>/dev/null))
    fi

    if [[ -n ${tkn_out} ]]; then
        [[ -n ${BASH_VERSION} ]] && COMPREPLY=( $( compgen -W "${tkn_out}" -- "$cur" ) )
        [[ -n ${ZSH_VERSION} ]] && compadd ${tkn_out}
    fi
}

function __kubectl_get_namespace() { __tkn_get_object namespace kubectl ;}
function __kubectl_get_serviceaccount() { __tkn_get_object serviceaccount kubectl ;}
function __tkn_get_pipeline() { __tkn_get_object pipeline tkn ;}
function __tkn_get_pipelinerun() { __tkn_get_object pipelinerun tkn ;}
function __tkn_get_task() { __tkn_get_object task tkn ;}
function __tkn_get_taskrun() { __tkn_get_object taskrun tkn ;}
function __tkn_get_pipelineresource() { __tkn_get_object resource tkn ;}
function __tkn_get_clustertasks() { __tkn_get_object clustertasks tkn ;}

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin

# The next line enables shell command completion for gcloud.
if [ -f '/Users/tibor.pilz/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/tibor.pilz/google-cloud-sdk/completion.zsh.inc'; fi

# Z
# . /usr/local/etc/profile.d/z.sh

# Fix gpg
export GPG_TTY=$(tty)
