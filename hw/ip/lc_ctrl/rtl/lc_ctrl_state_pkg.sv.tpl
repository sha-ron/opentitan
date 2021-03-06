// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Life cycle state encoding definition.
//
// DO NOT EDIT THIS FILE DIRECTLY.
// It has been generated with
// $ ./util/design/gen-lc-state-enc.py --seed ${lc_st_enc.config['seed']}
//
package lc_ctrl_state_pkg;
<%
data_width = lc_st_enc.config['secded']['data_width']
ecc_width  = lc_st_enc.config['secded']['ecc_width']
%>

  /////////////////////////////////////////////
  // Life cycle manufacturing state encoding //
  /////////////////////////////////////////////

  // These values have been generated such that they are incrementally writeable with respect
  // to the ECC polynomial specified. The values are used to define the life cycle manufacturing
  // state and transition counter encoding in lc_ctrl_pkg.sv.
  //
  // The values are unique and have the following statistics (considering all ${data_width}
  // data and ${ecc_width} ECC bits):
  //
  // - Minimum Hamming weight: ${lc_st_enc.gen['stats']['min_hw']}
  // - Maximum Hamming weight: ${lc_st_enc.gen['stats']['max_hw']}
  // - Minimum Hamming distance from any other value: ${lc_st_enc.gen['stats']['min_hd']}
  // - Maximum Hamming distance from any other value: ${lc_st_enc.gen['stats']['max_hd']}
  //
  // Hamming distance histogram:
  //
% for bar in lc_st_enc.gen['stats']['bars']:
  // ${bar}
% endfor
  //
  //
  // Note that the ECC bits are not defined in this package as they will be calculated by
  // the OTP ECC logic at runtime.

  // The A/B values are used for the encoded LC state.
% for word in lc_st_enc.gen['ab_words']:
  parameter logic [${data_width-1}:0] A${loop.index} = ${data_width}'b${word[0][ecc_width:]}; // ECC: ${ecc_width}'b${word[0][0:ecc_width]}
  parameter logic [${data_width-1}:0] B${loop.index} = ${data_width}'b${word[1][ecc_width:]}; // ECC: ${ecc_width}'b${word[1][0:ecc_width]}

% endfor

  // The C/D values are used for the encoded LC transition counter.
% for word in lc_st_enc.gen['cd_words']:
  parameter logic [${data_width-1}:0] C${loop.index} = ${data_width}'b${word[0][ecc_width:]}; // ECC: ${ecc_width}'b${word[0][0:ecc_width]}
  parameter logic [${data_width-1}:0] D${loop.index} = ${data_width}'b${word[1][ecc_width:]}; // ECC: ${ecc_width}'b${word[1][0:ecc_width]}

% endfor

  // The E/F values are used for the encoded ID state.
% for word in lc_st_enc.gen['ef_words']:
  parameter logic [${data_width-1}:0] E${loop.index} = ${data_width}'b${word[0][ecc_width:]}; // ECC: ${ecc_width}'b${word[0][0:ecc_width]}
  parameter logic [${data_width-1}:0] F${loop.index} = ${data_width}'b${word[1][ecc_width:]}; // ECC: ${ecc_width}'b${word[1][0:ecc_width]}

% endfor

  ///////////////////////////////////////////
  // Hashed RAW unlock and all-zero tokens //
  ///////////////////////////////////////////
<% token_size = lc_st_enc.config['token_size'] %>
% for token in lc_st_enc.config['tokens']:
  parameter logic [${token_size-1}:0] ${token['name']} = {
    ${"{0:}'h{1:0X}".format(token_size, token['value'])}
  };
% endfor

endpackage : lc_ctrl_state_pkg
