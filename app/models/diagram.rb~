class Diagram < ActiveRecord::Base

  def self.cash_flows(investment, marr, capacity, pur, puc, om, salv, horiz, deprec_type, deprec_time, db_per, loan_amt, loan_time, loan_interest_rate, loan_type, tax_rate)

    @cash_flows = []    #array to hold all cash flows

    horiz.to_i.times do |i|   #generate as many flows as there are periods in project horizon
    
      @capacity_flow = (1 - tax_rate/100)*(pur-puc)*capacity -(1 - tax_rate/100)*om

      @depreciation_flow = tax_rate*depreciation(investment, salv, deprec_time, deprec_type, db_per, i)

      @interest_pay_flow = (1 - tax_rate/100)*interest_pay(loan_amt, loan_time, loan_interest_rate, loan_type)

      if(i == 0)
        @principal_pay_flow, @loan_balance  = principal_pay(loan_amt, loan_time, loan_interest_rate, loan_type, loan_amt)   #loan balance in first run is original loan
      else
        @principal_pay_flow, @loan_balance  = principal_pay(loan_amt, loan_time, loan_interest_rate, loan_type, @loan_balance)  #every run thereafter, Bn = Bn-1 - PP
      end

      #flow is calculated anew each period
      @net_flow = @capacity_flow + @depreciation_flow - @interest_pay_flow - @principal_pay_flow

      if i == 0       #first period, only investment, loan amount, and half-year depreciation
        @net_flow = -investment + loan_amt + @depreciation_flow/2
      end

      if i == horiz - 1       #last period, add salvage amount
        @net_flow = @net_flow + salv 
      end

      if i == horiz     #year after last, add half-year depreciation
        @net_flow = @net_flow + @depreciation_flow/2
      end

      @cash_flows[i] = @net_flow

    end

    return @cash_flows
  end

  def self.depreciation(price, salvage, timeline, db_sl, percent, period)

    if(db_sl == true)   #if user selected Declining Balance -> SL
      @alpha = percent/timeline   #determine alpha (multipler / no. of periods)
      return price*@alpha*(1-@alpha)^(period - 1)

    else      #otherwise, if user selected Straight Line
      return (price - salvage)/timeline
    end
  end

  def self.interest_pay(balance, time, interest_rate, eq_principal)

      return balance*(interest_rate/100)    #no matter what, interest payment = i*B_n-1
  end

  def self.principal_pay(loan_amt, time, interest_rate, eq_principal, balance)

    if(eq_principal == true)    #if user selected Equal Principal Payments
      @principal_payment = loan_amt/time    
      balance = balance - @principal_payment
      return @principal_payment, balance

    else    #if user has selected Equal Total Payments
      @a_given_p = ((interest_rate/100)*(1+(interest_rate/100))**(time))/(((1+(interest_rate/100))**(time))-1)

      @total_payment = loan_amt*@a_given_p

      @interest_payment = loan_amt*(interest_rate/100)
      @principal_payment = @total_payment - @interest_payment
      balance = balance - @principal_payment

      return @principal_payment, balance
    end    
  end

  def self.present_worth(investment, marr, capacity, pur, puc, om, salv, horiz)
    
    @p_given_a = ((1+(marr/100))**(horiz)-1)/((1+(marr/100))**(horiz)-1)
    @p_given_f = 1/((1+(marr/100))**horiz)

    return -investment + (pur - puc)*capacity*@p_given_a - om*@p_given_a + salv*@p_given_f
  end

  def self.future_worth(investment, marr, capacity, pur, puc, om, salv, horiz)

    @f_given_a = ((1+(marr/100))**(horiz)-1)/(marr/100)
    @f_given_p = (1+(marr/100))**horiz

    return -investment*@f_given_p + (pur - puc)*capacity*@f_given_a - om*@f_given_a + salv
  end

  def self.annual_equivalent(investment, marr, capacity, pur, puc, om, salv, horiz)

    @a_given_p = ((marr/100)*(1+(marr/100))**(horiz))/(((1+(marr/100))**(horiz))-1)

    return present_worth(investment, marr, capacity, pur, puc, om, salv, horiz)*@a_given_p
  end

  def self.err(investment, marr, capacity, pur, puc, om, salv, horiz)

    @f_given_a = ((1+(marr/100))**(horiz)-1)/(marr/100)
    @p_given_f = 1/((1+(marr/100))**horiz)

    return ((@f_given_a/@p_given_f)**(1/horiz)) - 1
  end

  def self.payback_period(investment, marr, capacity, pur, puc, om, salv, horiz)

    @net = 0

    horiz.to_i.times do |i|

      if(i == 0)                          #in the first year, subtract investment
        @net = @net - investment
      

      elsif(i == horiz - 1)            #in the last year, add the salvage val
        @net = @net + salv
      
      else
        @net = @net + (pur - puc)*capacity - om     #in all other years, add net cash flow
      end

      if(@net >= 0)   #as soon as the total flow breaks even or is positive, return the number of the period
        return i
      end
    end
  end

  def self.pw_vs_mar(investment, marr, capacity, pur, puc, om, salv, horiz)

      @pws = []
      
       horiz.to_i.times do |i|
        @pws[i] = present_worth(investment, marr, capacity, pur, puc, om, salv, horiz)
       end
       
      return @pws
  end
      
end
