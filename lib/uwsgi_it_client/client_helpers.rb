require 'active_support/core_ext/array/wrap'

class UwsgiItClient
  module ClientHelpers
    def company=(value)
      post :me, {company: value}
    end

    def password=(value)
      post :me, {password: value}
    end

    def set_distro(d_id, c_id)
      post :container, {distro: d_id}, id: c_id
    end

    def add_keys(keys, c_id)
      post :container, {ssh_keys: keys}, id: c_id
    end

    def add_key(key, c_id)
      add_keys Array.wrap(key), c_id
    end

    def add_domain(name)
      post :domains, {name: name}
    end

    def delete_domain(name)
      delete :domains, {name: name}
    end
  end
end