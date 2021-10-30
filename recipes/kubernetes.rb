#
# Cookbook:: .dotfiles
# Recipe:: kubernetes
#
# Copyright:: 2019, The Authors, All Rights Reserved.


package 'kubectl' do
  options "-f"
end
package 'kops'

homebrew_tap 'derailed/k9s'
package 'derailed/k9s/k9s'
homebrew_tap 'derailed/k9s' do
  action :untap
end
package 'operator-sdk'
package 'kubectx'
package 'stern'
package 'istioctl'
package 'minikube'
