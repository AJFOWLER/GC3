#4. Show calculation
# -- Raj Thanguraja (Thursday Afternoons)

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
      		a = ((140-@patient.age)*(@ibw)*1.04)/@patient.creatinine
      	else
      		a = ((140-@patient.age)*(@ibw)*1.23)/@patient.creatinine
        end
        
        if a <= 20
          return "#{a.to_i}ml/min, NOT SAFE TO USE NORMAL DOSING -- contact pharmacy"
        
        else
          return "#{a.to_i}ml/min, safe to use normal dosing"
    end
  end
    
#def ibw
 # b = 154
	#diff = (@patient.height.to_i) - b
	#if @patient.gender == "Male"
	#	@ibw =  50 + (diff*(0.91))
	#else 
	#	@ibw =  45 + (diff*(0.91))
	#end
  
  #return @ibw
  #end
  def ibw
    inch = (@patient.height*(0.393))
    diff = inch.to_i - 60
    
    if @patient.gender == "Male"
      @ibw = 50 + (diff * 2.3)
    else
      @ibw = 45.5 + (diff * 2.3)
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
  
  if @dose >480
  return "Calculated dose of #{@dose} is higher than the recommended maximum dose of 480mg"
else
  return @dose
end
end

private
  def patient_params
    params.require(:patient).permit(:age, :creatinine, :weight, :gender, :height)
  end
end
