class Node
    attr_accessor :data,:next
    
    def initialize(data)
        @data = data
        @next = nil
    end 
  end
  
  class SingleLinkedList
        
      def initialize
        @head = nil
      end
      
      def push(data)
        newnode = Node.new(data)
        if @head == nil
           @head = newnode
           return
        end
        cur = @head
        while cur.next!= nil
          cur = cur.next
        end
        cur.next = newnode
      end
      
      #add at the front 
      def unshitft(data)
        newnode = Node.new(data)
        if @head == nil
            head = newnode
        end
        newnode.next = @head
        @head = newnode
      end
      
      #remove from the front
      def shift
        if @head == nil
          return "linked list is empty"
        end
         @head = @head.next
      end
      
      
      #remove from the last
      def pop
         if @head == nil
           return "linked list is empty"
         end
         cur = @head
         while cur.next.next != nil
             cur = cur.next
         end
         cur.next = nil
      end
      
      # #print
      def printlist
          cur = @head
          array = []
          if @head == nil
            return array
          end
          while cur.next != nil
              array << cur.data
              cur = cur.next
          end
          array << curr.data
          array
      end
  end
  
  s1 = SingleLinkedList.new
  
  s1.push(10)
  s1.push(20)
  s1.push(30)
  
  
  puts "print linked list #{s1.printlist}"