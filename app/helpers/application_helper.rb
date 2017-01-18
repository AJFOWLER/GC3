module ApplicationHelper
  
  def crcl()
      		if @gender == "Female"
      		@crcl = ((140-@age)*(@weight))/@creatinine
      	else
      		@crcl = ((140-@age)*(@weight*1.2))/@creatinine
         end 
      	if @crcl <=30 
      		puts "use renal dosing"
      	else
      		"Creatinine Clearance is #{a}ml/min, safe to use normal dosing"
      	end
      end


  def BMI()
      		bmi_height = @height.to_f/100
      		@bmi = (@weight / (bmi_height**2))
    end

  def ibw()
    a = 154
      		diff = (@height.to_i) - a
      		if @gender == "Male"
      			@ibw = 50 + (diff*(0.91))
      		else 
      			@ibw = 45 + (diff*(0.91))
      		end
        end


  def ddw()
      		return @ibw+(0.4 * (@weight.to_i - @ibw))
  end

  def define_dose(number)
  		x = (number.round*5)
  		if x > 480
  			puts "480mg is the maximum dose"
  		else
  			puts "Use #{x}mg"
  		end
  	end
    
  def dose_calculate()
          if (@weight.to_i) > @ibw * 1.20
      			@dose = define_dose(@ddw)
		
      		elsif (@weight.to_i) < @ibw
      			@dose = define_dose(@weight)
		
      		else 
      			@dose = define_dose(@ibw)
      		end
      end

end
