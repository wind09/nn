local ParallelTable, parent = torch.class('nn.ParallelTable', 'nn.Module')

function ParallelTable:__init()
   parent.__init(self)
   self.modules = {}
   self.output = {}
   self.gradInput = {}
end

function ParallelTable:add(module)
   table.insert(self.modules, module)
   return self
end

function ParallelTable:get(index)
   return self.modules[index]
end

function ParallelTable:size()
   return #self.modules 
end

function ParallelTable:updateOutput(input)
   for i=1,#self.modules do
      self.output[i] = self.modules[i]:updateOutput(input[i])
   end
   return self.output
end


function ParallelTable:updateGradInput(input, gradOutput)
   for i,module in ipairs(self.modules) do
      self.gradInput[i]= module:updateGradInput(input[i], gradOutput[i])
   end
   return self.gradInput
end

function ParallelTable:accGradParameters(input, gradOutput, scale)
   scale = scale or 1
   for i,module in ipairs(self.modules) do
      module:accGradParameters(input[i], gradOutput[i], scale)
   end
end

function ParallelTable:accUpdateGradParameters(input, gradOutput, lr)
   lr = lr or 1
   for i,module in ipairs(self.modules) do
      module:accUpdateGradParameters(input[i], gradOutput[i], lr)
   end
end

function ParallelTable:zeroGradParameters()
   for _,module in ipairs(self.modules) do
      module:zeroGradParameters()
   end
end

function ParallelTable:updateParameters(learningRate)
   for _,module in ipairs(self.modules) do
      module:updateParameters(learningRate)
   end
end

function ParallelTable:share(mlp,...)
   for i=1,#self.modules do
      self.modules[i]:share(mlp.modules[i],...); 
   end
end



