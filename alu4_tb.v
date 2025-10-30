`timescale 1ns/1ps
module alu4_tb;
    reg [3:0] A;
    reg [3:0] B;
    reg [2:0] op;
    wire [3:0] Y;
    wire zero, carry, overflow;
    
    integer error_count; // Counts failures

    // Instantiate the Unit Under Test (UUT)
    alu4 uut (.A(A), .B(B), .op(op), .Y(Y), .zero(zero), .carry(carry), .overflow(overflow));

    initial begin
        error_count = 0;
        
        // --- This is the new, aligned header ---
        $display("--- Starting 4-bit ALU Verification ---");
        $display("Time     | Test Case     | A  B | op  | Y(dec) | Y(bin) | z c o | Expected      | Status");
        $display("-----------------------------------------------------------------------------------------");
        
        // Test 1: ADD (3 + 1 = 4)
        A = 4'd3; B = 4'd1; op = 3'b000; #10000; // Corrected delay
        if (Y==4'd4 && zero==0 && carry==0 && overflow==0)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "ADD (3+1)", A, B, op, Y, Y, zero, carry, overflow, "Y=4");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "ADD (3+1)", A, B, op, Y, Y, zero, carry, overflow, "Y=4");
            error_count = error_count + 1;
        end

        // Test 2: SUB (3 - 1 = 2)
        A = 4'd3; B = 4'd1; op = 3'b001; #10000; // Corrected delay
        if (Y==4'd2)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "SUB (3-1)", A, B, op, Y, Y, zero, carry, overflow, "Y=2");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "SUB (3-1)", A, B, op, Y, Y, zero, carry, overflow, "Y=2");
            error_count = error_count + 1;
        end
        
        // Test 3: AND (3 & 1 = 1)
        A = 4'd3; B = 4'd1; op = 3'b010; #10000; // Corrected delay
        if (Y==4'd1)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "AND (3&1)", A, B, op, Y, Y, zero, carry, overflow, "Y=1");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "AND (3&1)", A, B, op, Y, Y, zero, carry, overflow, "Y=1");
            error_count = error_count + 1;
        end
        
        // Test 4: OR (3 | 1 = 3)
        A = 4'd3; B = 4'd1; op = 3'b011; #10000; // Corrected delay
        if (Y==4'd3)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "OR (3|1)", A, B, op, Y, Y, zero, carry, overflow, "Y=3");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "OR (3|1)", A, B, op, Y, Y, zero, carry, overflow, "Y=3");
            error_count = error_count + 1;
        end
        
        // Test 5: XOR (3 ^ 1 = 2)
        A = 4'd3; B = 4'd1; op = 3'b100; #10000; // Corrected delay
        if (Y==4'd2)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "XOR (3^1)", A, B, op, Y, Y, zero, carry, overflow, "Y=2");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "XOR (3^1)", A, B, op, Y, Y, zero, carry, overflow, "Y=2");
            error_count = error_count + 1;
        end

        // Test 6: NOT (~3 = 12)
        A = 4'd3; B = 4'd1; op = 3'b101; #10000; // Corrected delay
        if (Y==4'd12)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "NOT (~3)", A, B, op, Y, Y, zero, carry, overflow, "Y=12");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "NOT (~3)", A, B, op, Y, Y, zero, carry, overflow, "Y=12");
            error_count = error_count + 1;
        end

        // Test 7: INC (15 + 1 = 0, carry=1, zero=1)
        A = 4'd15; B = 4'd1; op = 3'b110; #10000; // Corrected delay
        if (Y==4'd0 && zero==1 && carry==1)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "INC (15+1)", A, B, op, Y, Y, zero, carry, overflow, "Y=0,z=1,c=1");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "INC (15+1)", A, B, op, Y, Y, zero, carry, overflow, "Y=0,z=1,c=1");
            error_count = error_count + 1;
        end
        
        // Test 8: DEC (0 - 1 = 15, carry=1)
        A = 4'd0; B = 4'd1; op = 3'b111; #10000; // Corrected delay
        if (Y==4'd15 && carry==1)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "DEC (0-1)", A, B, op, Y, Y, zero, carry, overflow, "Y=15,c=1");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "DEC (0-1)", A, B, op, Y, Y, zero, carry, overflow, "Y=15,c=1");
            error_count = error_count + 1;
        end

        // Test 9: OVERFLOW ADD (7 + 7 = 14, overflow=1)
        A = 4'd7; B = 4'd7; op = 3'b000; #10000; // Corrected delay
        if (Y==4'd14 && overflow==1)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "OVFL (7+7)", A, B, op, Y, Y, zero, carry, overflow, "Y=14,o=1");
        else begin
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "OVFL (7+7)", A, B, op, Y, Y, zero, carry, overflow, "Y=14,o=1");
            error_count = error_count + 1;
        end

        // Test 10: ZERO FLAG (3 - 3 = 0, zero=1)
        A = 4'd3; B = 4'd3; op = 3'b001; #10000; // Corrected delay
        if (Y==0 && zero==1)
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | PASS", $time, "ZERO (3-3)", A, B, op, Y, Y, zero, carry, overflow, "Y=0,z=1");
        else begin
            // *** THIS LINE IS NOW FIXED ***
            $display("%6tns | %-13s | %2d %2d | %3b | %-6d | %4b | %b %b %b | %-13s | ** FAIL **", $time, "ZERO (3-3)", A, B, op, Y, Y, zero, carry, overflow, "Y=0,z=1");
            error_count = error_count + 1;
        end

        // --- FINAL REPORT ---
        #10000; // Corrected delay
        if (error_count == 0)
            $display("\n--- ALL TESTS PASSED! ---");
        else
            $display("\n--- SIMULATION FAILED WITH %0d ERRORS ---", error_count);
            
        $stop;
    end
endmodule

