library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity streamCombine9_1_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M00_AXIS_START_COUNT	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 6;

		-- Parameters of Axi Slave Bus Interface S00_AXIS
		C_S00_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S01_AXIS
		C_S01_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S02_AXIS
		C_S02_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S03_AXIS
		C_S03_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S04_AXIS
		C_S04_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S05_AXIS
		C_S05_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S06_AXIS
		C_S06_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S07_AXIS
		C_S07_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S08_AXIS
		C_S08_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_aclk	: in std_logic;
		m00_axis_aresetn	: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
		m00_axis_tstrb	: out std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_aclk	: in std_logic;
		s00_axis_aresetn	: in std_logic;
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
		s00_axis_tstrb	: in std_logic_vector((C_S00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S01_AXIS
		s01_axis_aclk	: in std_logic;
		s01_axis_aresetn	: in std_logic;
		s01_axis_tready	: out std_logic;
		s01_axis_tdata	: in std_logic_vector(C_S01_AXIS_TDATA_WIDTH-1 downto 0);
		s01_axis_tstrb	: in std_logic_vector((C_S01_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s01_axis_tlast	: in std_logic;
		s01_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S02_AXIS
		s02_axis_aclk	: in std_logic;
		s02_axis_aresetn	: in std_logic;
		s02_axis_tready	: out std_logic;
		s02_axis_tdata	: in std_logic_vector(C_S02_AXIS_TDATA_WIDTH-1 downto 0);
		s02_axis_tstrb	: in std_logic_vector((C_S02_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s02_axis_tlast	: in std_logic;
		s02_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S03_AXIS
		s03_axis_aclk	: in std_logic;
		s03_axis_aresetn	: in std_logic;
		s03_axis_tready	: out std_logic;
		s03_axis_tdata	: in std_logic_vector(C_S03_AXIS_TDATA_WIDTH-1 downto 0);
		s03_axis_tstrb	: in std_logic_vector((C_S03_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s03_axis_tlast	: in std_logic;
		s03_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S04_AXIS
		s04_axis_aclk	: in std_logic;
		s04_axis_aresetn	: in std_logic;
		s04_axis_tready	: out std_logic;
		s04_axis_tdata	: in std_logic_vector(C_S04_AXIS_TDATA_WIDTH-1 downto 0);
		s04_axis_tstrb	: in std_logic_vector((C_S04_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s04_axis_tlast	: in std_logic;
		s04_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S05_AXIS
		s05_axis_aclk	: in std_logic;
		s05_axis_aresetn	: in std_logic;
		s05_axis_tready	: out std_logic;
		s05_axis_tdata	: in std_logic_vector(C_S05_AXIS_TDATA_WIDTH-1 downto 0);
		s05_axis_tstrb	: in std_logic_vector((C_S05_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s05_axis_tlast	: in std_logic;
		s05_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S06_AXIS
		s06_axis_aclk	: in std_logic;
		s06_axis_aresetn	: in std_logic;
		s06_axis_tready	: out std_logic;
		s06_axis_tdata	: in std_logic_vector(C_S06_AXIS_TDATA_WIDTH-1 downto 0);
		s06_axis_tstrb	: in std_logic_vector((C_S06_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s06_axis_tlast	: in std_logic;
		s06_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S07_AXIS
		s07_axis_aclk	: in std_logic;
		s07_axis_aresetn	: in std_logic;
		s07_axis_tready	: out std_logic;
		s07_axis_tdata	: in std_logic_vector(C_S07_AXIS_TDATA_WIDTH-1 downto 0);
		s07_axis_tstrb	: in std_logic_vector((C_S07_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s07_axis_tlast	: in std_logic;
		s07_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S08_AXIS
		s08_axis_aclk	: in std_logic;
		s08_axis_aresetn	: in std_logic;
		s08_axis_tready	: out std_logic;
		s08_axis_tdata	: in std_logic_vector(C_S08_AXIS_TDATA_WIDTH-1 downto 0);
		s08_axis_tstrb	: in std_logic_vector((C_S08_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s08_axis_tlast	: in std_logic;
		s08_axis_tvalid	: in std_logic
	);
end streamCombine9_1_v1_0;

architecture arch_imp of streamCombine9_1_v1_0 is

	-- component declaration
	component streamCombine9_1_v1_0_M00_AXIS is
		generic (
		C_M_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M_START_COUNT       	: integer	:= 32
		);
		port (
		M_AXIS_ACLK   	: in std_logic;
		M_AXIS_ARESETN	: in std_logic;
		M_AXIS_TVALID	: out std_logic;
		M_AXIS_TDATA	: out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
		M_AXIS_TSTRB	: out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
		M_AXIS_TLAST	: out std_logic;
		M_AXIS_TREADY	: in std_logic
		);
	end component streamCombine9_1_v1_0_M00_AXIS;

	component streamCombine9_1_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 6
		);
		port (
		weight0_i_axi : out std_logic_vector(11 downto 0);
        weight1_i_axi : out std_logic_vector(11 downto 0);
        weight2_i_axi : out std_logic_vector(11 downto 0);
        weight3_i_axi : out std_logic_vector(11 downto 0);
        weight4_i_axi : out std_logic_vector(11 downto 0);
        weight5_i_axi : out std_logic_vector(11 downto 0);
        weight6_i_axi : out std_logic_vector(11 downto 0);
        weight7_i_axi : out std_logic_vector(11 downto 0);
        weight8_i_axi : out std_logic_vector(11 downto 0);
        
        weight0_q_axi : out std_logic_vector(11 downto 0);
        weight1_q_axi : out std_logic_vector(11 downto 0);
        weight2_q_axi : out std_logic_vector(11 downto 0);
        weight3_q_axi : out std_logic_vector(11 downto 0);
        weight4_q_axi : out std_logic_vector(11 downto 0);
        weight5_q_axi : out std_logic_vector(11 downto 0);
        weight6_q_axi : out std_logic_vector(11 downto 0);
        weight7_q_axi : out std_logic_vector(11 downto 0);
        weight8_q_axi : out std_logic_vector(11 downto 0);
		
		S_AXI_ACLK    	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA   	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB   	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP   	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA   	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP   	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component streamCombine9_1_v1_0_S00_AXI;

	component streamCombine9_1_v1_0_S00_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S00_AXIS;

	component streamCombine9_1_v1_0_S01_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S01_AXIS;

	component streamCombine9_1_v1_0_S02_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S02_AXIS;

	component streamCombine9_1_v1_0_S03_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S03_AXIS;

	component streamCombine9_1_v1_0_S04_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S04_AXIS;

	component streamCombine9_1_v1_0_S05_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S05_AXIS;

	component streamCombine9_1_v1_0_S06_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S06_AXIS;

	component streamCombine9_1_v1_0_S07_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S07_AXIS;

	component streamCombine9_1_v1_0_S08_AXIS is
		generic (
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
		);
		port (
		S_AXIS_ACLK   	: in std_logic;
		S_AXIS_ARESETN	: in std_logic;
		S_AXIS_TREADY	: out std_logic;
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		S_AXIS_TLAST	: in std_logic;
		S_AXIS_TVALID	: in std_logic
		);
	end component streamCombine9_1_v1_0_S08_AXIS;

	component ps2pl_12b_fifo is -- fifo for timing 
		port (
			srst	 : in std_logic;
			wr_clk	 : in std_logic;
			rd_clk	 : in std_logic;
			din		 : in std_logic_vector(11 DOWNTO 0);
			wr_en	 : in std_logic;
			rd_en	 : in std_logic;
			dout	 : out std_logic_vector(11 DOWNTO 0);
			full	 : out std_logic;
			empty	 : out std_logic;
			valid	 : out std_logic
		);
	end component ps2pl_12b_fifo;


-- my signals

-- ps2pl fifo write data signals
signal din_weight0_i : std_logic_vector(11 downto 0);
signal din_weight1_i : std_logic_vector(11 downto 0);
signal din_weight2_i : std_logic_vector(11 downto 0);
signal din_weight3_i : std_logic_vector(11 downto 0);
signal din_weight4_i : std_logic_vector(11 downto 0);
signal din_weight5_i : std_logic_vector(11 downto 0);
signal din_weight6_i : std_logic_vector(11 downto 0);
signal din_weight7_i : std_logic_vector(11 downto 0);
signal din_weight8_i : std_logic_vector(11 downto 0);

signal din_weight0_q : std_logic_vector(11 downto 0);
signal din_weight1_q : std_logic_vector(11 downto 0);
signal din_weight2_q : std_logic_vector(11 downto 0);
signal din_weight3_q : std_logic_vector(11 downto 0);
signal din_weight4_q : std_logic_vector(11 downto 0);
signal din_weight5_q : std_logic_vector(11 downto 0);
signal din_weight6_q : std_logic_vector(11 downto 0);
signal din_weight7_q : std_logic_vector(11 downto 0);
signal din_weight8_q : std_logic_vector(11 downto 0);


-- ps2pl fifo read data signals 
signal weight0_i : std_logic_vector(11 downto 0);
signal weight1_i : std_logic_vector(11 downto 0);
signal weight2_i : std_logic_vector(11 downto 0);
signal weight3_i : std_logic_vector(11 downto 0);
signal weight4_i : std_logic_vector(11 downto 0);
signal weight5_i : std_logic_vector(11 downto 0);
signal weight6_i : std_logic_vector(11 downto 0);
signal weight7_i : std_logic_vector(11 downto 0);
signal weight8_i : std_logic_vector(11 downto 0);

signal weight0_q : std_logic_vector(11 downto 0);
signal weight1_q : std_logic_vector(11 downto 0);
signal weight2_q : std_logic_vector(11 downto 0);
signal weight3_q : std_logic_vector(11 downto 0);
signal weight4_q : std_logic_vector(11 downto 0);
signal weight5_q : std_logic_vector(11 downto 0);
signal weight6_q : std_logic_vector(11 downto 0);
signal weight7_q : std_logic_vector(11 downto 0);
signal weight8_q : std_logic_vector(11 downto 0);

-- ps2pl_12b fifo timing signals 
signal ps2pl_fifo_rst : std_logic; -- system reset for all fifo
signal rst_cnt, rst_axis_cnt: integer := 0;
signal lms_fifo_wr_en, lms_fifo_rd_en: std_logic; 

-- product signals
signal I_prod0 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod0 : std_logic_vector(25 downto 0)  := (others => '0');
signal I_prod1 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod1 : std_logic_vector(25 downto 0)  := (others => '0');
signal I_prod2 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod2 : std_logic_vector(25 downto 0)  := (others => '0');
signal I_prod3 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod3 : std_logic_vector(25 downto 0)  := (others => '0');
signal I_prod4 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod4 : std_logic_vector(25 downto 0)  := (others => '0');
signal I_prod5 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod5 : std_logic_vector(25 downto 0)  := (others => '0');
signal I_prod6 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod6 : std_logic_vector(25 downto 0)  := (others => '0');
signal I_prod7 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod7 : std_logic_vector(25 downto 0)  := (others => '0');
signal I_prod8 : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_prod8 : std_logic_vector(25 downto 0)  := (others => '0');

signal I_out   : std_logic_vector(25 downto 0)  := (others => '0');
signal Q_out   : std_logic_vector(25 downto 0)  := (others => '0');

signal result_out   : std_logic_vector(31 downto 0)  := (others => '0');


begin

-- Instantiation of Axi Bus Interface M00_AXIS
streamCombine9_1_v1_0_M00_AXIS_inst : streamCombine9_1_v1_0_M00_AXIS
	generic map (
		C_M_AXIS_TDATA_WIDTH	=> C_M00_AXIS_TDATA_WIDTH,
		C_M_START_COUNT       	=> C_M00_AXIS_START_COUNT
	)
	port map (
		M_AXIS_ACLK   	=> m00_axis_aclk,
		M_AXIS_ARESETN	=> m00_axis_aresetn,
		M_AXIS_TVALID	=> m00_axis_tvalid,
--		M_AXIS_TDATA	=> m00_axis_tdata, --**
		M_AXIS_TSTRB	=> m00_axis_tstrb,
		M_AXIS_TLAST	=> m00_axis_tlast,
		M_AXIS_TREADY	=> m00_axis_tready
	);

-- Instantiation of Axi Bus Interface S00_AXI
streamCombine9_1_v1_0_S00_AXI_inst : streamCombine9_1_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (

--         weight0_i_axi  => weight0_i, 
--         weight1_i_axi  => weight1_i,
--         weight2_i_axi  => weight2_i,
--         weight3_i_axi  => weight3_i,
--         weight4_i_axi  => weight4_i,
--         weight5_i_axi  => weight5_i,
--         weight6_i_axi  => weight6_i,
--         weight7_i_axi  => weight7_i,
--         weight8_i_axi  => weight8_i,
        
--         weight0_q_axi => weight0_q,
--         weight1_q_axi => weight1_q,
--         weight2_q_axi => weight2_q,
--         weight3_q_axi => weight3_q,
--         weight4_q_axi => weight4_q,
--         weight5_q_axi => weight5_q,
--         weight6_q_axi => weight6_q,
--         weight7_q_axi => weight7_q,
--         weight8_q_axi => weight8_q,

        weight0_i_axi  => din_weight0_i, 
        weight1_i_axi  => din_weight1_i,
        weight2_i_axi  => din_weight2_i,
        weight3_i_axi  => din_weight3_i,
        weight4_i_axi  => din_weight4_i,
        weight5_i_axi  => din_weight5_i,
        weight6_i_axi  => din_weight6_i,
        weight7_i_axi  => din_weight7_i,
        weight8_i_axi  => din_weight8_i,
        
        weight0_q_axi => din_weight0_q,
        weight1_q_axi => din_weight1_q,
        weight2_q_axi => din_weight2_q,
        weight3_q_axi => din_weight3_q,
        weight4_q_axi => din_weight4_q,
        weight5_q_axi => din_weight5_q,
        weight6_q_axi => din_weight6_q,
        weight7_q_axi => din_weight7_q,
        weight8_q_axi => din_weight8_q,
        
        S_AXI_ACLK    	=> s00_axi_aclk,
        S_AXI_ARESETN	=> s00_axi_aresetn,
        S_AXI_AWADDR	=> s00_axi_awaddr,
        S_AXI_AWPROT	=> s00_axi_awprot,
        S_AXI_AWVALID	=> s00_axi_awvalid,
        S_AXI_AWREADY	=> s00_axi_awready,
        S_AXI_WDATA   	=> s00_axi_wdata,
        S_AXI_WSTRB   	=> s00_axi_wstrb,
        S_AXI_WVALID	=> s00_axi_wvalid,
        S_AXI_WREADY	=> s00_axi_wready,
        S_AXI_BRESP   	=> s00_axi_bresp,
        S_AXI_BVALID	=> s00_axi_bvalid,
        S_AXI_BREADY	=> s00_axi_bready,
        S_AXI_ARADDR	=> s00_axi_araddr,
        S_AXI_ARPROT	=> s00_axi_arprot,
        S_AXI_ARVALID	=> s00_axi_arvalid,
        S_AXI_ARREADY	=> s00_axi_arready,
        S_AXI_RDATA   	=> s00_axi_rdata,
        S_AXI_RRESP   	=> s00_axi_rresp,
        S_AXI_RVALID	=> s00_axi_rvalid,
        S_AXI_RREADY	=> s00_axi_rready
	);

-- Instantiation of Axi Bus Interface S00_AXIS
streamCombine9_1_v1_0_S00_AXIS_inst : streamCombine9_1_v1_0_S00_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S00_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s00_axis_aclk,
		S_AXIS_ARESETN	=> s00_axis_aresetn,
		S_AXIS_TREADY	=> s00_axis_tready,
		S_AXIS_TDATA	=> s00_axis_tdata,
		S_AXIS_TSTRB	=> s00_axis_tstrb,
		S_AXIS_TLAST	=> s00_axis_tlast,
		S_AXIS_TVALID	=> s00_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S01_AXIS
streamCombine9_1_v1_0_S01_AXIS_inst : streamCombine9_1_v1_0_S01_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S01_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s01_axis_aclk,
		S_AXIS_ARESETN	=> s01_axis_aresetn,
		S_AXIS_TREADY	=> s01_axis_tready,
		S_AXIS_TDATA	=> s01_axis_tdata,
		S_AXIS_TSTRB	=> s01_axis_tstrb,
		S_AXIS_TLAST	=> s01_axis_tlast,
		S_AXIS_TVALID	=> s01_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S02_AXIS
streamCombine9_1_v1_0_S02_AXIS_inst : streamCombine9_1_v1_0_S02_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S02_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s02_axis_aclk,
		S_AXIS_ARESETN	=> s02_axis_aresetn,
		S_AXIS_TREADY	=> s02_axis_tready,
		S_AXIS_TDATA	=> s02_axis_tdata,
		S_AXIS_TSTRB	=> s02_axis_tstrb,
		S_AXIS_TLAST	=> s02_axis_tlast,
		S_AXIS_TVALID	=> s02_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S03_AXIS
streamCombine9_1_v1_0_S03_AXIS_inst : streamCombine9_1_v1_0_S03_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S03_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s03_axis_aclk,
		S_AXIS_ARESETN	=> s03_axis_aresetn,
		S_AXIS_TREADY	=> s03_axis_tready,
		S_AXIS_TDATA	=> s03_axis_tdata,
		S_AXIS_TSTRB	=> s03_axis_tstrb,
		S_AXIS_TLAST	=> s03_axis_tlast,
		S_AXIS_TVALID	=> s03_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S04_AXIS
streamCombine9_1_v1_0_S04_AXIS_inst : streamCombine9_1_v1_0_S04_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S04_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s04_axis_aclk,
		S_AXIS_ARESETN	=> s04_axis_aresetn,
		S_AXIS_TREADY	=> s04_axis_tready,
		S_AXIS_TDATA	=> s04_axis_tdata,
		S_AXIS_TSTRB	=> s04_axis_tstrb,
		S_AXIS_TLAST	=> s04_axis_tlast,
		S_AXIS_TVALID	=> s04_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S05_AXIS
streamCombine9_1_v1_0_S05_AXIS_inst : streamCombine9_1_v1_0_S05_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S05_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s05_axis_aclk,
		S_AXIS_ARESETN	=> s05_axis_aresetn,
		S_AXIS_TREADY	=> s05_axis_tready,
		S_AXIS_TDATA	=> s05_axis_tdata,
		S_AXIS_TSTRB	=> s05_axis_tstrb,
		S_AXIS_TLAST	=> s05_axis_tlast,
		S_AXIS_TVALID	=> s05_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S06_AXIS
streamCombine9_1_v1_0_S06_AXIS_inst : streamCombine9_1_v1_0_S06_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S06_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s06_axis_aclk,
		S_AXIS_ARESETN	=> s06_axis_aresetn,
		S_AXIS_TREADY	=> s06_axis_tready,
		S_AXIS_TDATA	=> s06_axis_tdata,
		S_AXIS_TSTRB	=> s06_axis_tstrb,
		S_AXIS_TLAST	=> s06_axis_tlast,
		S_AXIS_TVALID	=> s06_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S07_AXIS
streamCombine9_1_v1_0_S07_AXIS_inst : streamCombine9_1_v1_0_S07_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S07_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s07_axis_aclk,
		S_AXIS_ARESETN	=> s07_axis_aresetn,
		S_AXIS_TREADY	=> s07_axis_tready,
		S_AXIS_TDATA	=> s07_axis_tdata,
		S_AXIS_TSTRB	=> s07_axis_tstrb,
		S_AXIS_TLAST	=> s07_axis_tlast,
		S_AXIS_TVALID	=> s07_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S08_AXIS
streamCombine9_1_v1_0_S08_AXIS_inst : streamCombine9_1_v1_0_S08_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S08_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK   	=> s08_axis_aclk,
		S_AXIS_ARESETN	=> s08_axis_aresetn,
		S_AXIS_TREADY	=> s08_axis_tready,
		S_AXIS_TDATA	=> s08_axis_tdata,
		S_AXIS_TSTRB	=> s08_axis_tstrb,
		S_AXIS_TLAST	=> s08_axis_tlast,
		S_AXIS_TVALID	=> s08_axis_tvalid
	);

-- Instantiation of FIFO Generator Bus Interface: weight0_i
w0i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight0_i,
        wr_en	 => lms_fifo_wr_en, --?
        rd_en	 => lms_fifo_rd_en, --? 
        dout	 => weight0_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight1_i
w1i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight1_i,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight1_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);
	
-- Instantiation of FIFO Generator Bus Interface: weight2_i
w2i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight2_i,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight2_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight3_i
w3i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight3_i,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight3_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight4_i
w4i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight4_i,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight4_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight5_i
w5i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight5_i,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight5_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight6_i
w6i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight6_i,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight6_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight7_i
w7i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight7_i,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight7_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight8_i
w8i_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight8_i,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight8_i,
        full	 => open,
        empty	 => open,
        valid	 => open
	);



-- Instantiation of FIFO Generator Bus Interface: weight0_q
w0q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight0_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight0_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight1_q
w1q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight1_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight1_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight2_q
w2q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight2_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight2_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight3_q
w3q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight3_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight3_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight4_q
w4q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight4_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight4_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight5_q
w5q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight5_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight5_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight6_q
w6q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight6_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight6_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight7_q
w7q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight7_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight7_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);

-- Instantiation of FIFO Generator Bus Interface: weight8_q
w8q_ps2pl_12b_fifo : ps2pl_12b_fifo 
	port map (
        srst	 => ps2pl_fifo_rst,
        wr_clk	 => s00_axi_aclk,
        rd_clk	 => s00_axis_aclk,
        din		 => din_weight8_q,
        wr_en	 => lms_fifo_wr_en,
        rd_en	 => lms_fifo_rd_en,
        dout	 => weight8_q,
        full	 => open,
        empty	 => open,
        valid	 => open
	);


	-- Add user logic here

--logic for inital reset to FIFO, only goes high once
process(s00_axi_aclk)
	begin
		if (rising_edge(s00_axi_aclk)) then
			if(rst_cnt < 600) then
				rst_cnt <= rst_cnt + 1;
			end if;

			if (rst_cnt < 500) then
				ps2pl_fifo_rst <= '1'; 
				lms_fifo_wr_en <= '0';
			else
				ps2pl_fifo_rst <= '0';
				lms_fifo_wr_en <= '1';
			end if;
		end if; -- if rising edge of clock
	end process;	

process(s00_axis_aclk)
	begin
		if (rising_edge(s00_axis_aclk)) then

			if(rst_axis_cnt < 1050) then
				rst_axis_cnt <= rst_axis_cnt + 1;
			end if;

			if (rst_axis_cnt < 1050) then
				lms_fifo_rd_en <= '0'; 
		
			else
				lms_fifo_rd_en <= '1'; 
				
			end if;
			
		end if; -- if rising edge of clock
	end process;


-- calulations

multiply : process (m00_axis_aresetn,m00_axis_aclk) -- combine weights and data
    begin
    
        if m00_axis_aresetn = '0' then             -- asynchronous reset (active low)
            I_prod0  <= (others => '0');
            Q_prod0  <= (others => '0');
            I_prod1  <= (others => '0');
            Q_prod1  <= (others => '0');
            I_prod2  <= (others => '0');
            Q_prod2  <= (others => '0');
            I_prod3  <= (others => '0');
            Q_prod3  <= (others => '0');
            I_prod4  <= (others => '0');
            Q_prod4  <= (others => '0');
            I_prod5  <= (others => '0');
            Q_prod5  <= (others => '0');
            I_prod6  <= (others => '0');
            Q_prod6  <= (others => '0');
            I_prod7  <= (others => '0');
            Q_prod7  <= (others => '0');
            I_prod8  <= (others => '0');
            Q_prod8  <= (others => '0');
            
        elsif rising_edge(m00_axis_aclk) then 
    
            I_prod0  <= std_logic_vector( (signed(weight0_i) * signed(s00_axis_tdata(13 downto 0))) - (signed(weight0_q) * signed(s00_axis_tdata(29 downto 16))) );
            Q_prod0  <= std_logic_vector( (signed(weight0_q) * signed(s00_axis_tdata(13 downto 0))) + (signed(weight0_i) * signed(s00_axis_tdata(29 downto 16))) );
           
            I_prod1  <= std_logic_vector( (signed(weight1_i) * signed(s01_axis_tdata(13 downto 0))) - (signed(weight1_q) * signed(s01_axis_tdata(29 downto 16))) );
            Q_prod1  <= std_logic_vector( (signed(weight1_q) * signed(s01_axis_tdata(13 downto 0))) + (signed(weight1_i) * signed(s01_axis_tdata(29 downto 16))) );
        
            I_prod2  <= std_logic_vector( (signed(weight2_i) * signed(s02_axis_tdata(13 downto 0))) - (signed(weight2_q) * signed(s02_axis_tdata(29 downto 16))) );
            Q_prod2  <= std_logic_vector( (signed(weight2_q) * signed(s02_axis_tdata(13 downto 0))) + (signed(weight2_i) * signed(s02_axis_tdata(29 downto 16))) );
    
            I_prod3  <= std_logic_vector( (signed(weight3_i) * signed(s03_axis_tdata(13 downto 0))) - (signed(weight3_q) * signed(s03_axis_tdata(29 downto 16))) );
            Q_prod3  <= std_logic_vector( (signed(weight3_q) * signed(s03_axis_tdata(13 downto 0))) + (signed(weight3_i) * signed(s03_axis_tdata(29 downto 16))) );
            
            I_prod4  <= std_logic_vector( (signed(weight4_i) * signed(s04_axis_tdata(13 downto 0))) - (signed(weight4_q) * signed(s04_axis_tdata(29 downto 16))) );
            Q_prod4  <= std_logic_vector( (signed(weight4_q) * signed(s04_axis_tdata(13 downto 0))) + (signed(weight4_i) * signed(s04_axis_tdata(29 downto 16))) );
            
            I_prod5  <= std_logic_vector( (signed(weight5_i) * signed(s05_axis_tdata(13 downto 0))) - (signed(weight5_q) * signed(s05_axis_tdata(29 downto 16))) );
            Q_prod5  <= std_logic_vector( (signed(weight5_q) * signed(s05_axis_tdata(13 downto 0))) + (signed(weight5_i) * signed(s05_axis_tdata(29 downto 16))) );
    
            I_prod6  <= std_logic_vector( (signed(weight6_i) * signed(s06_axis_tdata(13 downto 0))) - (signed(weight6_q) * signed(s06_axis_tdata(29 downto 16))) );
            Q_prod6  <= std_logic_vector( (signed(weight6_q) * signed(s06_axis_tdata(13 downto 0))) + (signed(weight6_i) * signed(s06_axis_tdata(29 downto 16))) );
        
            I_prod7  <= std_logic_vector( (signed(weight7_i) * signed(s07_axis_tdata(13 downto 0))) - (signed(weight7_q) * signed(s07_axis_tdata(29 downto 16))) );
            Q_prod7  <= std_logic_vector( (signed(weight7_q) * signed(s07_axis_tdata(13 downto 0))) + (signed(weight7_i) * signed(s07_axis_tdata(29 downto 16))) );
            
            I_prod8  <= std_logic_vector( (signed(weight8_i) * signed(s08_axis_tdata(13 downto 0))) - (signed(weight8_q) * signed(s08_axis_tdata(29 downto 16))) );
            Q_prod8  <= std_logic_vector( (signed(weight8_q) * signed(s08_axis_tdata(13 downto 0))) + (signed(weight8_i) * signed(s08_axis_tdata(29 downto 16))) );
      
            
        end if;    
    end process multiply;
    
    add : process (m00_axis_aresetn,m00_axis_aclk) -- combine weights and data
    begin
    
        if m00_axis_aresetn = '0' then             -- asynchronous reset (active low)
            I_out   <= (others => '0');
            Q_out   <= (others => '0');
            
        elsif rising_edge(m00_axis_aclk) then -- multiply first then sum, possible loop function
            I_out  <= std_logic_vector(  signed(I_prod0) + signed(I_prod1) + signed(I_prod2) 
                                       + signed(I_prod3) + signed(I_prod4) + signed(I_prod5) 
                                       + signed(I_prod6) + signed(I_prod7) + signed(I_prod8) );
    
            Q_out  <= std_logic_vector(  signed(Q_prod0) + signed(Q_prod1) + signed(Q_prod2) 
                                       + signed(Q_prod3) + signed(Q_prod4) + signed(Q_prod5) 
                                       + signed(Q_prod6) + signed(Q_prod7) + signed(Q_prod8) );
        end if;    
    end process add;
    
    concat : process (m00_axis_aresetn,m00_axis_aclk)
    begin
        if m00_axis_aresetn = '0' then             -- asynchronous reset (active low)
            result_out <= (others => '0');
            
        elsif rising_edge(m00_axis_aclk) then
            result_out(31 downto 16) <= Q_out(25 downto 10);
            result_out(15 downto 0)  <= I_out(25 downto 10);
            
        end if;
    end process concat;
    
    m00_axis_tdata <= result_out;

	-- User logic ends

end arch_imp;
