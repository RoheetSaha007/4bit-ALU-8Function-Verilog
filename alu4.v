`timescale 1ns/1ps
module alu4 (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire [2:0] op,
    output reg  [3:0] Y,
    output reg        zero,
    output reg        carry,
    output reg        overflow
);
    wire [4:0] add_res = {1'b0, A} + {1'b0, B};
    wire [4:0] sub_res = {1'b0, A} - {1'b0, B};

    always @(*) begin
        // Default outputs to prevent latches
        Y = 4'b0000; 
        zero = 0; 
        carry = 0; 
        overflow = 0;
        
        case (op)
            // 000: ADD
            3'b000: begin 
                Y = add_res[3:0]; 
                carry = add_res[4]; 
                overflow = (~A[3] & ~B[3] & Y[3]) | (A[3] & B[3] & ~Y[3]); 
            end
            
            // 001: SUB
            3'b001: begin 
                Y = sub_res[3:0]; 
                carry = sub_res[4]; // This is the 'borrow' bit
                overflow = (A[3] & ~B[3] & ~Y[3]) | (~A[3] & B[3] & Y[3]); 
            end
            
            // 010: AND
            3'b010: Y = A & B;
            
            // 011: OR
            3'b011: Y = A | B;
            
            // 100: XOR
            3'b100: Y = A ^ B;
            
            // 101: NOT
            3'b101: Y = ~A;
            
            // 110: INC
            3'b110: begin 
                Y = A + 1; 
                carry = (A == 4'b1111); // Carry out on 15+1
            end
            
            // 111: DEC
            3'b111: begin 
                Y = A - 1; 
                carry = (A == 4'b0000); // Borrow on 0-1
            end
        endcase
        
        // Zero flag logic (applies to all operations)
        zero = (Y == 4'b0000);
    end
endmodule

