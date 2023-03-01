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

module aluControlUnit (
    input  wire [1:0] alu_op, 
    input  wire [5:0] instruction_5_0, 
    output wire [3:0] alu_out
    );

// ------------------------------
// Insert your solution below
// ------------------------------ 

    reg alu_out_reg;

    assign alu_out = alu_out_reg;
/*
    controlUnit #() get_op(
        .instr_op(instruction_5_0),
        .alu_op(alu_op));
    */
    
    always @(*) begin
        casex({alu_op,instruction_5_0})
            8'b00XXXXXX: begin
                alu_out_reg = 4'b0010;
            end
            8'bX1XXXXXX: begin
                alu_out_reg = 4'b0110;
            end
            8'b1XXX0000:begin
                alu_out_reg = 4'b0010;
            end
            8'b1XXX0000: begin
                alu_out_reg = 4'b0110;
            end
            8'b1XXX0010: begin
                alu_out_reg = 4'b0000;
            end
            8'b1XXX0100:begin
                alu_out_reg = 4'b0001;
            end
            8'b1XXX1010:begin
                alu_out_reg = 4'b0111;
            end
            8'b1XXX0111:begin
                alu_out_reg = 4'b1100;
            end
        endcase
    end


endmodule
