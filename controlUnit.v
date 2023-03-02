//=========================================================================
// Name & Email must be EXACTLY as in Gradescope roster!
// Name: Nicole Navarro  
// Email: nnava026@ucr.edu
// 
// Assignment name: Lab 4 Datapath Control units
// Lab section: 021
// TA: Jincong Lu
// 
// I hereby certify that I have not received assistance on this assignment,
// or used code, from ANY outside source other than the instruction team
// (apart from what was provided in the starter file).
//
//=========================================================================

module controlUnit  (
    input  wire [5:0] instr_op, 
    output wire       reg_dst,   
    output wire       branch,     
    output wire       mem_read,  
    output wire       mem_to_reg,
    output wire [1:0] alu_op,        
    output wire       mem_write, 
    output wire       alu_src,    
    output wire       reg_write
    );

// ------------------------------
// Insert your solution below
// ------------------------------ 
    
    reg reg_dst_reg; 
    reg branch_reg;
    reg mem_read_reg;
    reg mem_to_reg_reg;
    reg [1:0] alu_op_reg;
    reg mem_write_reg;
    reg alu_src_reg;
    reg reg_write_reg;

    assign reg_st = reg_dst_reg;
    assign branch = branch_reg;
    assign mem_read = mem_read_reg;
    assign mem_to_reg = mem_to_reg_reg;
    assign alu_op = alu_op_reg;
    assign mem_write = mem_write_reg;
    assign alu_src = alu_src_reg;
    assign reg_write = reg_write_reg;

    always @(*) begin
        case(instr_op)
            6'b000000: begin
                reg_dst_reg = 1'b1;
                branch_reg = 1'b0;
                mem_read_reg = 1'b0;
                mem_to_reg_reg = 1'b0;
                alu_op_reg = 2'b10;
                mem_write_reg = 1'b0;
                alu_src_reg = 1'b0;
                reg_write_reg = 1'b1;
            end
            6'b100011: begin
                reg_dst_reg = 1'b0;
                branch_reg = 1'b0;
                mem_read_reg = 1'b1;
                mem_to_reg_reg = 1'b1;
                alu_op_reg = 2'b00;
                mem_write_reg = 1'b0;
                alu_src_reg = 1'b1;
                reg_write_reg = 1'b1;
            end
            6'b101011: begin
                reg_dst_reg = 1'bX;
                branch_reg = 1'b0;
                mem_read_reg = 1'b0;
                mem_to_reg_reg = 1'bX;
                alu_op_reg = 2'b00;
                mem_write_reg = 1'b1;
                alu_src_reg = 1'b1;
                reg_write_reg = 1'b0;
            end
            6'b000100: begin
                reg_dst_reg = 1'bX;
                branch_reg = 1'b1;
                mem_read_reg = 1'b0;
                mem_to_reg_reg = 1'bX;
                alu_op_reg = 2'b01;
                mem_write_reg = 1'b0;
                alu_src_reg = 1'b0;
                reg_write_reg = 1'b0;
            end
            6'b001000: begin
                reg_dst_reg = 1'b1;
                branch_reg = 1'b0;
                mem_read_reg = 1'b0;
                mem_to_reg_reg = 1'b0;
                alu_op_reg = 2'b10;
                mem_write_reg = 1'b0;
                alu_src_reg = 1'b1;
                reg_write_reg = 1'b1;
            end
        endcase

    end


endmodule
