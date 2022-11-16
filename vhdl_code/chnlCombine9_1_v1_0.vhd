library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity chnlCombine9_1_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Master Bus Interface M00_AXIS
		C_M00_AXIS_TDATA_WIDTH	: integer	:= 32;
		C_M00_AXIS_START_COUNT	: integer	:= 32;

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
		C_S08_AXIS_TDATA_WIDTH	: integer	:= 32;

		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 6
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Master Bus Interface M00_AXIS
		m00_axis_aclk	: in std_logic;
		m00_axis_aresetn: in std_logic;
		m00_axis_tvalid	: out std_logic;
		m00_axis_tdata	: out std_logic_vector(C_M00_AXIS_TDATA_WIDTH-1 downto 0);
		m00_axis_tstrb	: out std_logic_vector((C_M00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		m00_axis_tlast	: out std_logic;
		m00_axis_tready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S00_AXIS
		s00_axis_aclk	: in std_logic;
		s00_axis_aresetn: in std_logic;
		s00_axis_tready	: out std_logic;
		s00_axis_tdata	: in std_logic_vector(C_S00_AXIS_TDATA_WIDTH-1 downto 0);
		s00_axis_tstrb	: in std_logic_vector((C_S00_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s00_axis_tlast	: in std_logic;
		s00_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S01_AXIS
		s01_axis_aclk	: in std_logic;
		s01_axis_aresetn: in std_logic;
		s01_axis_tready	: out std_logic;
		s01_axis_tdata	: in std_logic_vector(C_S01_AXIS_TDATA_WIDTH-1 downto 0);
		s01_axis_tstrb	: in std_logic_vector((C_S01_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s01_axis_tlast	: in std_logic;
		s01_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S02_AXIS
		s02_axis_aclk	: in std_logic;
		s02_axis_aresetn: in std_logic;
		s02_axis_tready	: out std_logic;
		s02_axis_tdata	: in std_logic_vector(C_S02_AXIS_TDATA_WIDTH-1 downto 0);
		s02_axis_tstrb	: in std_logic_vector((C_S02_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s02_axis_tlast	: in std_logic;
		s02_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S03_AXIS
		s03_axis_aclk	: in std_logic;
		s03_axis_aresetn: in std_logic;
		s03_axis_tready	: out std_logic;
		s03_axis_tdata	: in std_logic_vector(C_S03_AXIS_TDATA_WIDTH-1 downto 0);
		s03_axis_tstrb	: in std_logic_vector((C_S03_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s03_axis_tlast	: in std_logic;
		s03_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S04_AXIS
		s04_axis_aclk	: in std_logic;
		s04_axis_aresetn: in std_logic;
		s04_axis_tready	: out std_logic;
		s04_axis_tdata	: in std_logic_vector(C_S04_AXIS_TDATA_WIDTH-1 downto 0);
		s04_axis_tstrb	: in std_logic_vector((C_S04_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s04_axis_tlast	: in std_logic;
		s04_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S05_AXIS
		s05_axis_aclk	: in std_logic;
		s05_axis_aresetn: in std_logic;
		s05_axis_tready	: out std_logic;
		s05_axis_tdata	: in std_logic_vector(C_S05_AXIS_TDATA_WIDTH-1 downto 0);
		s05_axis_tstrb	: in std_logic_vector((C_S05_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s05_axis_tlast	: in std_logic;
		s05_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S06_AXIS
		s06_axis_aclk	: in std_logic;
		s06_axis_aresetn: in std_logic;
		s06_axis_tready	: out std_logic;
		s06_axis_tdata	: in std_logic_vector(C_S06_AXIS_TDATA_WIDTH-1 downto 0);
		s06_axis_tstrb	: in std_logic_vector((C_S06_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s06_axis_tlast	: in std_logic;
		s06_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S07_AXIS
		s07_axis_aclk	: in std_logic;
		s07_axis_aresetn: in std_logic;
		s07_axis_tready	: out std_logic;
		s07_axis_tdata	: in std_logic_vector(C_S07_AXIS_TDATA_WIDTH-1 downto 0);
		s07_axis_tstrb	: in std_logic_vector((C_S07_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s07_axis_tlast	: in std_logic;
		s07_axis_tvalid	: in std_logic;

		-- Ports of Axi Slave Bus Interface S08_AXIS
		s08_axis_aclk	: in std_logic;
		s08_axis_aresetn: in std_logic;
		s08_axis_tready	: out std_logic;
		s08_axis_tdata	: in std_logic_vector(C_S08_AXIS_TDATA_WIDTH-1 downto 0);
		s08_axis_tstrb	: in std_logic_vector((C_S08_AXIS_TDATA_WIDTH/8)-1 downto 0);
		s08_axis_tlast	: in std_logic;
		s08_axis_tvalid	: in std_logic;

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
		s00_axi_rready	: in std_logic
	);
end chnlCombine9_1_v1_0;

architecture arch_imp of chnlCombine9_1_v1_0 is

	-- component declaration
	component chnlCombine9_1_v1_0_M00_AXIS is
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
	end component chnlCombine9_1_v1_0_M00_AXIS;

	component chnlCombine9_1_v1_0_S00_AXIS is
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
	end component chnlCombine9_1_v1_0_S00_AXIS;

	component chnlCombine9_1_v1_0_S01_AXIS is
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
	end component chnlCombine9_1_v1_0_S01_AXIS;

	component chnlCombine9_1_v1_0_S02_AXIS is
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
	end component chnlCombine9_1_v1_0_S02_AXIS;

	component chnlCombine9_1_v1_0_S03_AXIS is
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
	end component chnlCombine9_1_v1_0_S03_AXIS;

	component chnlCombine9_1_v1_0_S04_AXIS is
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
	end component chnlCombine9_1_v1_0_S04_AXIS;

	component chnlCombine9_1_v1_0_S05_AXIS is
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
	end component chnlCombine9_1_v1_0_S05_AXIS;

	component chnlCombine9_1_v1_0_S06_AXIS is
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
	end component chnlCombine9_1_v1_0_S06_AXIS;

	component chnlCombine9_1_v1_0_S07_AXIS is
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
	end component chnlCombine9_1_v1_0_S07_AXIS;

	component chnlCombine9_1_v1_0_S08_AXIS is
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
	end component chnlCombine9_1_v1_0_S08_AXIS;

	component chnlCombine9_1_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 6
		);
		port (
        weight0_axi : out std_logic_vector(23 downto 0);
        weight1_axi : out std_logic_vector(23 downto 0);
        weight2_axi : out std_logic_vector(23 downto 0);
        weight3_axi : out std_logic_vector(23 downto 0);
        weight4_axi : out std_logic_vector(23 downto 0);
        weight5_axi : out std_logic_vector(23 downto 0);
        weight6_axi : out std_logic_vector(23 downto 0);
        weight7_axi : out std_logic_vector(23 downto 0);
        weight8_axi : out std_logic_vector(23 downto 0);
		
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
	end component chnlCombine9_1_v1_0_S00_AXI;

-- matrix defined in order to use a for loop for calculations
type w_matrix is array (0 to 8) of std_logic_vector(11 downto 0); -- weights, S2_10
    
-- store I values of the weights
signal weights_I : w_matrix;

-- store Q values of the weights
signal weights_Q : w_matrix;


-- my signals
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


begin

-- Instantiation of Axi Bus Interface M00_AXIS
chnlCombine9_1_v1_0_M00_AXIS_inst : chnlCombine9_1_v1_0_M00_AXIS
	generic map (
		C_M_AXIS_TDATA_WIDTH	=> C_M00_AXIS_TDATA_WIDTH,
		C_M_START_COUNT	=> C_M00_AXIS_START_COUNT
	)
	port map (
		M_AXIS_ACLK	=> m00_axis_aclk,
		M_AXIS_ARESETN	=> m00_axis_aresetn,
		M_AXIS_TVALID	=> m00_axis_tvalid,
		M_AXIS_TDATA	=> m00_axis_tdata,
		M_AXIS_TSTRB	=> m00_axis_tstrb,
		M_AXIS_TLAST	=> m00_axis_tlast,
		M_AXIS_TREADY	=> m00_axis_tready
	);

-- Instantiation of Axi Bus Interface S00_AXIS
chnlCombine9_1_v1_0_S00_AXIS_inst : chnlCombine9_1_v1_0_S00_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S00_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK	=> s00_axis_aclk,
		S_AXIS_ARESETN	=> s00_axis_aresetn,
		S_AXIS_TREADY	=> s00_axis_tready,
		S_AXIS_TDATA	=> s00_axis_tdata,
		S_AXIS_TSTRB	=> s00_axis_tstrb,
		S_AXIS_TLAST	=> s00_axis_tlast,
		S_AXIS_TVALID	=> s00_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S01_AXIS
chnlCombine9_1_v1_0_S01_AXIS_inst : chnlCombine9_1_v1_0_S01_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S01_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK	=> s01_axis_aclk,
		S_AXIS_ARESETN	=> s01_axis_aresetn,
		S_AXIS_TREADY	=> s01_axis_tready,
		S_AXIS_TDATA	=> s01_axis_tdata,
		S_AXIS_TSTRB	=> s01_axis_tstrb,
		S_AXIS_TLAST	=> s01_axis_tlast,
		S_AXIS_TVALID	=> s01_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S02_AXIS
chnlCombine9_1_v1_0_S02_AXIS_inst : chnlCombine9_1_v1_0_S02_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S02_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK	=> s02_axis_aclk,
		S_AXIS_ARESETN	=> s02_axis_aresetn,
		S_AXIS_TREADY	=> s02_axis_tready,
		S_AXIS_TDATA	=> s02_axis_tdata,
		S_AXIS_TSTRB	=> s02_axis_tstrb,
		S_AXIS_TLAST	=> s02_axis_tlast,
		S_AXIS_TVALID	=> s02_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S03_AXIS
chnlCombine9_1_v1_0_S03_AXIS_inst : chnlCombine9_1_v1_0_S03_AXIS
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
chnlCombine9_1_v1_0_S04_AXIS_inst : chnlCombine9_1_v1_0_S04_AXIS
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
chnlCombine9_1_v1_0_S05_AXIS_inst : chnlCombine9_1_v1_0_S05_AXIS
	generic map (
		C_S_AXIS_TDATA_WIDTH	=> C_S05_AXIS_TDATA_WIDTH
	)
	port map (
		S_AXIS_ACLK     => s05_axis_aclk,
		S_AXIS_ARESETN	=> s05_axis_aresetn,
		S_AXIS_TREADY	=> s05_axis_tready,
		S_AXIS_TDATA	=> s05_axis_tdata,
		S_AXIS_TSTRB	=> s05_axis_tstrb,
		S_AXIS_TLAST	=> s05_axis_tlast,
		S_AXIS_TVALID	=> s05_axis_tvalid
	);

-- Instantiation of Axi Bus Interface S06_AXIS
chnlCombine9_1_v1_0_S06_AXIS_inst : chnlCombine9_1_v1_0_S06_AXIS
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
chnlCombine9_1_v1_0_S07_AXIS_inst : chnlCombine9_1_v1_0_S07_AXIS
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
chnlCombine9_1_v1_0_S08_AXIS_inst : chnlCombine9_1_v1_0_S08_AXIS
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

-- Instantiation of Axi Bus Interface S00_AXI
chnlCombine9_1_v1_0_S00_AXI_inst : chnlCombine9_1_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	    weight0_axi(11 downto 0) => weights_I(0),
	    weight1_axi(11 downto 0) => weights_I(1),
	    weight2_axi(11 downto 0) => weights_I(2),
	    weight3_axi(11 downto 0) => weights_I(3),
	    weight4_axi(11 downto 0) => weights_I(4),
	    weight5_axi(11 downto 0) => weights_I(5),
        weight6_axi(11 downto 0) => weights_I(6),
        weight7_axi(11 downto 0) => weights_I(7),
        weight8_axi(11 downto 0) => weights_I(8),
        
        weight0_axi(23 downto 12) => weights_Q(0),
        weight1_axi(23 downto 12) => weights_Q(1),
        weight2_axi(23 downto 12) => weights_Q(2),
        weight3_axi(23 downto 12) => weights_Q(3),
        weight4_axi(23 downto 12) => weights_Q(4),
        weight5_axi(23 downto 12) => weights_Q(5),
        weight6_axi(23 downto 12) => weights_Q(6),
        weight7_axi(23 downto 12) => weights_Q(7),
        weight8_axi(23 downto 12) => weights_Q(8),
        
	    
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

	-- Add user logic here

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
    
            I_prod0  <= std_logic_vector( (signed(weights_I(0)) * signed(s00_axis_tdata(13 downto 0))) - (signed(weights_Q(0)) * signed(s00_axis_tdata(29 downto 16))) );
            Q_prod0  <= std_logic_vector( (signed(weights_Q(0)) * signed(s00_axis_tdata(13 downto 0))) + (signed(weights_I(0)) * signed(s00_axis_tdata(29 downto 16))) );
           
            I_prod1  <= std_logic_vector( (signed(weights_I(1)) * signed(s01_axis_tdata(13 downto 0))) - (signed(weights_Q(1)) * signed(s01_axis_tdata(29 downto 16))) );
            Q_prod1  <= std_logic_vector( (signed(weights_Q(1)) * signed(s01_axis_tdata(13 downto 0))) + (signed(weights_I(1)) * signed(s01_axis_tdata(29 downto 16))) );
            
            I_prod2  <= std_logic_vector( (signed(weights_I(2)) * signed(s02_axis_tdata(13 downto 0))) - (signed(weights_Q(2)) * signed(s02_axis_tdata(29 downto 16))) );
            Q_prod2  <= std_logic_vector( (signed(weights_Q(2)) * signed(s02_axis_tdata(13 downto 0))) + (signed(weights_I(2)) * signed(s02_axis_tdata(29 downto 16))) );
    
            I_prod3  <= std_logic_vector( (signed(weights_I(3)) * signed(s03_axis_tdata(13 downto 0))) - (signed(weights_Q(3)) * signed(s03_axis_tdata(29 downto 16))) );
            Q_prod3  <= std_logic_vector( (signed(weights_Q(3)) * signed(s03_axis_tdata(13 downto 0))) + (signed(weights_I(3)) * signed(s03_axis_tdata(29 downto 16))) );
            
            I_prod4  <= std_logic_vector( (signed(weights_I(4)) * signed(s04_axis_tdata(13 downto 0))) - (signed(weights_Q(4)) * signed(s04_axis_tdata(29 downto 16))) );
            Q_prod4  <= std_logic_vector( (signed(weights_Q(4)) * signed(s04_axis_tdata(13 downto 0))) + (signed(weights_I(4)) * signed(s04_axis_tdata(29 downto 16))) );
            
            I_prod5  <= std_logic_vector( (signed(weights_I(5)) * signed(s05_axis_tdata(13 downto 0))) - (signed(weights_Q(5)) * signed(s05_axis_tdata(29 downto 16))) );
            Q_prod5  <= std_logic_vector( (signed(weights_Q(5)) * signed(s05_axis_tdata(13 downto 0))) + (signed(weights_I(5)) * signed(s05_axis_tdata(29 downto 16))) );
    
            I_prod6  <= std_logic_vector( (signed(weights_I(6)) * signed(s06_axis_tdata(13 downto 0))) - (signed(weights_Q(6)) * signed(s06_axis_tdata(29 downto 16))) );
            Q_prod6  <= std_logic_vector( (signed(weights_Q(6)) * signed(s06_axis_tdata(13 downto 0))) + (signed(weights_I(6)) * signed(s06_axis_tdata(29 downto 16))) );
            
            I_prod7  <= std_logic_vector( (signed(weights_I(7)) * signed(s07_axis_tdata(13 downto 0))) - (signed(weights_Q(7)) * signed(s07_axis_tdata(29 downto 16))) );
            Q_prod7  <= std_logic_vector( (signed(weights_Q(7)) * signed(s07_axis_tdata(13 downto 0))) + (signed(weights_I(7)) * signed(s07_axis_tdata(29 downto 16))) );
            
            I_prod8  <= std_logic_vector( (signed(weights_I(8)) * signed(s08_axis_tdata(13 downto 0))) - (signed(weights_Q(8)) * signed(s08_axis_tdata(29 downto 16))) );
            Q_prod8  <= std_logic_vector( (signed(weights_Q(8)) * signed(s08_axis_tdata(13 downto 0))) + (signed(weights_I(8)) * signed(s08_axis_tdata(29 downto 16))) );
      
            
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
            

            -- m00_axis_tdata is the focus here --> 32 bit total 
            -- first 16 bits (31 downto 16) is Q
            -- last 16 bits (15 downto 0) is I
            -- so am i keeping this or what
                -- how many sig figs am i carrying over?
                -- output bit length of I/Q_prod is S18_10
            -- got my answer: ***
                -- so it will be 16 bits for I and 16 bits for Q
                -- get rid of the 10 fractional bits when transmitting out for this project
                -- so actually the packet is 16 bits long, but there will only be data in (14 downto 0) i think?
            -- 4 full clock cycles to get an output

        end if;    
    end process add;
    
    m00_axis_tdata(31 downto 16) <= Q_out(25 downto 10);
    m00_axis_tdata(15 downto 0 ) <= I_out(25 downto 10);

	-- User logic ends

end arch_imp;
