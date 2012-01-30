class EmployeesController < ApplicationController
  layout 'employees_groups_posts'
    def update
        @employee = Employee.find(params[:id])

        respond_to do |format|
            if @employee.update_attributes(params[:employee])
                format.html { redirect_to(@employee) }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @employee.errors, :status => :unprocessable_entity }
            end
        end
    end
    
  def show
    @employee = Employee.find(params[:id])
    @id = @employee.id
    @name = @employee.name
    @groups = @employee.groups
  end
end
