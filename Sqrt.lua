local Sqrt, parent = torch.class('nn.Sqrt','nn.Module')

function Sqrt:__init(args)
   parent.__init(self)
end

function Sqrt:updateOutput(input)
   return input.nn.Sqrt_updateOutput(self,input)
end

function Sqrt:updateGradInput(input, gradOutput)
   return input.nn.Sqrt_updateGradInput(self,input,gradOutput)
end
