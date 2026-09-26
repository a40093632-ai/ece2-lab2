# 전자전기컴퓨터설계실험Ⅱ LAB2

순차논리회로 실험 11~18의 Verilog HDL 소스, 시뮬레이션 결과,
Vivado 구현 결과, bitstream 및 FPGA 보드 시연 자료를 정리한 저장소이다.

## 보고서

- [실험 전 보고서](<reports/pre/LAB2_실험전보고서_2023440129_조성현.pdf>)
- [실험 후 보고서](<reports/post/LAB2_실험후보고서_2023440129_조성현.pdf>)

## 실험 결과 및 시연 자료

| 실험 | 회로 | 소스 | VS Code | Vivado | Bitstream | 사진 | 영상 |
|---|---|---|---|---|---|---|---|
| 11 | Up/Down Counter | [소스](lab2_01_counter/) | [결과](evidence/11/vscode/) | [결과](evidence/11/vivado/) | [bit](artifacts/bit/lab2_counter.bit) | [사진](<evidence/11/board/photos/실험1 시연.png>) | [영상](evidence/11/board/videos/회로1.mp4) |
| 12 | Clock Divider | [소스](lab2_02_clock_divider/) | [결과](evidence/12/vscode/) | [결과](evidence/12/vivado/) | [bit](artifacts/bit/lab2_clock_divider.bit) | [사진](<evidence/12/board/photos/실험2 시연.png>) | [영상](evidence/12/board/videos/회로2.mp4) |
| 13 | Register | [소스](lab2_03_register/) | [결과](evidence/13/vscode/) | [결과](evidence/13/vivado/) | [bit](artifacts/bit/lab2_register.bit) | [사진](<evidence/13/board/photos/실험3 시연.png>) | [영상](evidence/13/board/videos/회로3.mp4) |
| 14 | Shift Register | [소스](lab2_04_shift_register/) | [결과](evidence/14/vscode/) | [결과](evidence/14/vivado/) | [bit](artifacts/bit/lab2_shift_register.bit) | [사진](<evidence/14/board/photos/실험4 시연.png>) | [영상](evidence/14/board/videos/회로4.mp4) |
| 15 | PISO | [소스](lab2_05_piso/) | [결과](evidence/15/vscode/) | [결과](evidence/15/vivado/) | [bit](artifacts/bit/lab2_piso.bit) | [사진](<evidence/15/board/photos/실험5 시연.png>) | [영상](evidence/15/board/videos/회로5.mp4) |
| 16 | Moore FSM | [소스](lab2_06_moore/) | [결과](evidence/16/vscode/) | [결과](evidence/16/vivado/) | [bit](artifacts/bit/lab2_moore.bit) | [사진](<evidence/16/board/photos/실험6 시연.png>) | [영상](evidence/16/board/videos/회로6.mp4) |
| 17 | Mealy FSM | [소스](lab2_07_mealy/) | [결과](evidence/17/vscode/) | [결과](evidence/17/vivado/) | [bit](artifacts/bit/lab2_mealy.bit) | [사진](<evidence/17/board/photos/실험7 시연.png>) | [영상](evidence/17/board/videos/회로7.mp4) |
| 18 | 7-Segment Scan | [소스](lab2_08_segment_scan/) | [결과](evidence/18/vscode/) | [결과](evidence/18/vivado/) | [bit](artifacts/bit/lab2_segment_scan.bit) | [사진](<evidence/18/board/photos/실험8 시연.png>) | [영상](evidence/18/board/videos/회로8.mp4) |

## 통합 회로 사전 검증

- [통합 회로 소스](lab2_08a_integrated/)
- [VS Code 시뮬레이션 증빙](evidence/18A/vscode/)

## 기준 정보

- FPGA: Combo II-DLD S75
- Part: `xc7s75fgga484-1`
- Vivado: 2026.1
- 제출 태그: `lab2-post-v1`