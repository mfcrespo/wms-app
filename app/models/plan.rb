class Plan

  PLANS = [:free, :moderate, :unlimited]

  def self.option
    PLANS.map { |plan| [plan.capitalize, plan] }
  end
end