module Device::Abilities::Switchable

  def included?(base)
    base.attribute :role, String, :default => 'guest'
  end
end



#module Device::Abilities::Switchable

  #def self.included(base)
    #base.ephemeral_attribute :binary_state
  #end

  #def binary_state
    #@binary_state || default_binary_state
  #end

  #def binary_state=(state)
    #raise unless valid_binary_states.include? state
    #@binary_state = state
  #end

  #def on
    #self.binary_state = :on
    #self.apply_state
  #end

  #def off
    #self.binary_state = :off
    #self.apply_state
  #end

  #def on?
    #self.binary_state == :on
  #end

  #def off?
    #self.binary_state == :off
  #end

  #def toggle
    #self.on? ? self.off : self.on
  #end

  #def valid_binary_states
    #[:on, :off, :unknown]
  #end

  #def default_binary_state
    #:unknown
  #end
#end
