module Api
  class IssuesController < ApplicationController
    def index
      @issues = current_nation.issues
      render :index
    end

    def show
      @issue = Issue.find(params[:id])
      if @issue
        render :show
      else
        render json: ["Issue not found"], status: 404
      end
    end

    def respond
      @issue_option = IssueOption.find(params[:id])
      new_ec_freedom = current_nation.ec_freedom + @issue_option.ec_freedom
      new_soc_freedom = current_nation.soc_freedom + @issue_option.soc_freedom
      new_pol_freedom = current_nation.pol_freedom + @issue_option.pol_freedom
      new_tax_rate = current_nation.tax_rate + @issue_option.tax_rate
      new_ecosystem = current_nation.ecosystem + @issue_option.ecosystem
      nation_params = {
        ec_freedom: new_ec_freedom,
        soc_freedom: new_soc_freedom,
        pol_freedom: new_pol_freedom,
        tax_rate: new_tax_rate,
        ecosystem: new_ecosystem
      }
      if current_nation.update_attributes(nation_params)
        render :index
      else
        render json: current_nation.errors.full_messages,
               status: :unprocessable_entity
      end
    end

    private
    def issue_params
      params.require(:issue).permit(:title, :body)
    end
  end
end
