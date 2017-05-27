if defined?(ChefSpec)
  def nvm_install(version)
    ChefSpec::Matchers::ResourceMatcher.new(:nvm_install, :create, version)
  end
end
