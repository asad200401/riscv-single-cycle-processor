`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2026 07:45:39 PM
// Design Name: 
// Module Name: data_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_mem(
    input logic clk,
    input logic [31:0]addr,dataW,
    input logic memRw,      
    input logic [2:0]func3,
    output logic [31:0]dataR
);

    logic [31:0] dmem [0:511];
    logic [31:0]data;

    always_comb begin
        if(!memRw)
            data = dmem[addr[31:2]]; // Fetch word from memory
        else
            data = 32'd0;
    end

    // read (comb)
    always_comb begin
        if(!memRw) begin
            case(func3)
                3'b000: begin  //lb
                    case(addr[1:0])
                        0: dataR = {{24{data[7]}},data[7:0]};
                        1: dataR = {{24{data[15]}},data[15:8]};
                        2: dataR = {{24{data[23]}},data[23:16]};
                        3: dataR = {{24{data[31]}},data[31:24]};
                    endcase
                end
                3'b001: begin  //lh
                    case(addr[1])
                        0: dataR = {{16{data[15]}},data[15:0]};
                        1: dataR = {{16{data[31]}},data[31:16]};
                    endcase
                end
                3'b010:  //lw
                    dataR = data;
                3'b100: begin  //lbu
                    case(addr[1:0])
                        0: dataR = {24'd0,data[7:0]};
                        1: dataR = {24'd0,data[15:8]};
                        2: dataR = {24'd0,data[23:16]};
                        3: dataR = {24'd0,data[31:24]};
                    endcase
                end
                3'b101: begin  //lhu
                    case(addr[1])
                        0: dataR = {16'd0,data[15:0]};
                        1: dataR = {16'd0,data[31:16]};
                    endcase
                end
                default:
                    dataR = 32'd0;

            endcase
        end
    end

    // write (seq)
    always_ff @(negedge clk) begin
        if(memRw) begin
            case(func3)
                3'b000: begin  //sb
                    case(addr[1:0])
                        0: dmem[addr[31:2]][7:0] <= dataW[7:0];
                        1: dmem[addr[31:2]][15:8] <= dataW[7:0];
                        2: dmem[addr[31:2]][23:16] <= dataW[7:0];
                        3: dmem[addr[31:2]][31:24] <= dataW[7:0];
                    endcase
                end
                3'b001: begin  //sh
                    case(addr[1])
                        0: dmem[addr[31:2]][15:0] <= dataW[15:0];
                        1: dmem[addr[31:2]][31:16] <= dataW[15:0];
                    endcase
                end
                3'b010:  //sw
                    dmem[addr[31:2]] <= dataW;
            endcase
        end
    end
endmodule