class WelcomeController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
    # authorize @wikis
  end

  def about
  end
end
