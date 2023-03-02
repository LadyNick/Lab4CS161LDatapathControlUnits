//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Nicole Navarro      
// Email: nnava026@ucr.edu
// 
// Assignment name: Lab 4 Datapath Control Units
// Lab section: 021
// TA: Jincong Lu
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

`timescale 1ns / 1ps

module datapath_tb;
    // Inputs
    reg clk; 
    reg [5:0] instr_op;    
    reg [5:0] instr_field;

    wire [8:0] result;
    wire [3:0] alu_result;

    reg [8:0] R;
    reg [3:0] R_alu;

    // -------------------------------------------------------
    // Setup output file for possible debugging uses
    // -------------------------------------------------------
    initial
    begin
        $dumpfile("lab04.vcd");
        $dumpvars(0);
    end
    
    // ---------------------------------------------------
    // Instantiate the Units Under Test (UUT)
    // --------------------------------------------------- 

    wire [1:0] alu_op_out;

    controlUnit #() connectionscu(
        .instr_op(instr_op),
        .reg_dst(result[8]),
        .alu_src(result[7]),
        .mem_to_reg(result[6]),
        .reg_write(result[5]),
        .mem_read(result[4]),
        .mem_write(result[3]),
        .branch(result[2]),
        .alu_op(result[1:0])
    );

    aluControlUnit #() connectionsacu(
        .alu_op(result[1:0]),
        .instruction_5_0(instr_field),
        .alu_out(alu_result)
    );


    initial begin 
        clk = 0;
        forever begin 
            clk = ~clk; #10; 
        end 
    end
     
    integer failedTests = 0;
    integer totalTests = 0;
    initial begin
        // Reset
        @(posedge clk); // Wait for first clock out of reset 
        #10; // Wait 

        // -------------------------------------------------------
        // Test group 1: Control Unit
        // -------------------------------------------------------
        $display("Test Group 1: Testing Control unit... ");

        $write("\tTest Case 1.1: R-format ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        R = { 9'b100100010 }; 
        #100; // Wait
        if (R !== result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        // -------------------------------------------------------
        // More Control Unit tests here
        // -------------------------------------------------------

        $write("\tTest Case 1.2: LW ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b100011;
        R = { 9'b011110000 }; 
        #100; // Wait
        if (R !== result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 1.3: SW ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b101011;
        R = { 9'bX1X001000 }; 
        #100; // Wait
        if (R !== result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 1.4: BEQ ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000100;
        R = { 9'bX0X000101 }; 
        #100; // Wait
        if (R !== result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        //WE HAVE TO FIGURE OUT IMM VALUES
        
        $write("\tTest Case 1.5: IMM ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        R = { 9'b110100010 };
        #100; // Wait
        if (R !== result) begin
            $display("failed: Expected: %b, got %b", R, result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        // -------------------------------------------------------
        // Test group 2: ALU Control Unit
        // -------------------------------------------------------
        $display("\nTest Group 2: Testing ALU Control unit... ");

        $write("\tTest Case 2.1: R-type (add) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100000;
        R_alu = { 4'b0010 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        // -------------------------------------------------------
        // More ALU Control Unit tests jere
        // -------------------------------------------------------

        //Based on the first test, going with the 2nd chart in README
        //Funct field is instr_field
        // instr_op is input op from earlier tests
        //R_alu is referring to ALU select input

        $write("\tTest Case 2.2: R-type (subtract) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100010;
        R_alu = { 4'b0110 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.3: R-type (AND) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100100;
        R_alu = { 4'b0000 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.4: R-type (OR) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100101;
        R_alu = { 4'b0001 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.5: R-type (NOR) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b100111;
        R_alu = { 4'b1100 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.6: R-type (Set on less than) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000000;
        instr_field = 6'b101010;
        R_alu = { 4'b0111 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.7: LW (load word)...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b100011;
        instr_field = 6'bXXXXXX;
        R_alu = { 4'b0010 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.8: SW (store word) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b101011;
        instr_field = 6'bXXXXXX;
        R_alu = { 4'b0010 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.9: BEQ (branch equal) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b000100;
        instr_field = 6'bXXXXXX;
        R_alu = { 4'b0110 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        //--------------

        $write("\tTest Case 2.10: R-type IMM (add) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        instr_field = 6'b100000;
        R_alu = { 4'b0010 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.11: R-type IMM (subtract) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        instr_field = 6'b100010;
        R_alu = { 4'b0110 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.12: R-type IMM (AND) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        instr_field = 6'b100100;
        R_alu = { 4'b0000 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.13: R-type IMM (OR) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        instr_field = 6'b100101;
        R_alu = { 4'b0001 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.14: R-type IMM (NOR) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        instr_field = 6'b100111;
        R_alu = { 4'b1100 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end

        $write("\tTest Case 2.15: R-type IMM (Set on less than) ...");
        totalTests = totalTests + 1;
        // Set inputs
        instr_op = 6'b001000;
        instr_field = 6'b101010;
        R_alu = { 4'b0111 }; 
        #100; // Wait
        if (R_alu !== alu_result) begin
            $display("failed: Expected: %b, got %b", R_alu, alu_result); 
            failedTests = failedTests + 1;
        end else begin
            $display("passed"); 
        end


        // --------------------------------------------------------------
        // End testing
        // --------------------------------------------------------------
        $write("\n--------------------------------------------------------------");
        $write("\nTesting complete\nPassed %0d / %0d tests",totalTests-failedTests,totalTests);
        $write("\n--------------------------------------------------------------\n");
        $finish();
    end
endmodule

//------For case study & notes 3/1
// tar xvf sf case_study.tar.gz
// cd study/
// ls
// bash: make: command not found
// apt update && apt install -y build-essential
// make
// ls
//run program from 100 to 30,000 ...
//    time ./prog0.out 100    .... then he tried 1000 so on
// o(n^2), different entries exist in different pages, you have to be constantly loading and reading and writing and so on
// we have to take a 2 dimensional object and put it into a 1 dimensional object RAM
// memory access patterns