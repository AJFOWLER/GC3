class PatientsController < ApplicationController
  helper_method :calculate_dose, :ibw, :ddw, :crcl
  
def new
  @patient = Patient.new
end

def create
  @patient = Patient.new(patient_params)
  if @patient.save
    redirect_to @patient
  end
end

def show
  @patient = Patient.find(params[:id])
end

  def crcl()
      	if @patient.gender == "Female"
      		a = ((140-@patient.age)*(@patient.weight))/@patient.creatinine
      	else
      		a = ((140-@patient.age)*(@patient.weight*1.2))/@patient.creatinine
        end
        
        if a <=30 
      		puts "use renal dosing"
      	else
      		"Creatinine Clearance is #{a}ml/min, safe to use normal dosing"
      	end
    end
def ibw
  a = 154
	diff = (@patient.height.to_i) - a
	if @patient.gender == "Male"
		@ibw =  50 + (diff*(0.91))
	else 
		@ibw =  45 + (diff*(0.91))
	end
  
  return @ibw
end

def ddw
  @ddw = @ibw+(0.4*(@patient.weight.to_i - @ibw))
end

def calculate_dose()
  if (@patient.weight.to_i) > @ibw * 1.20
		@dose = @ddw.round*5

	elsif (@patient.weight.to_i) < ibw
		@dose = @patient.weight.round*5

	else 
		@dose = @ibw.round*5
	end
  
  return @dose
end

private
  def patient_params
    params.require(:patient).permit(:age, :creatinine, :weight, :gender, :height)
  end
end
