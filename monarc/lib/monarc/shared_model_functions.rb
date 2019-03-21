module SharedModelFunctions

	
	
	def destroy_the_children
       if (self.children != nil)
        self.children.destroy_all
       end   
    end
    
	def grab_version
       if (self.security_policy != nil)
        return self.security_policy.version
       else
         return "not set"
       end
    end
    
  
   
 
end