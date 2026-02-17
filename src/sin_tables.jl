# sin_tables.jl — Lookup tables for correctly-rounded sin(Float64)
#
# Auto-extracted from core-math's src/binary64/sin/sin.c
# Original: Copyright (c) 2022-2025 Paul Zimmermann and Tom Hubrecht (MIT license)

# 1/(2pi) approximation: 1/(2pi) ≈ T[1]/2^64 + T[2]/2^128 + ...
const T = UInt64[
    0x28be60db9391054a,  # i=0
    0x7f09d5f47d4d3770,  # i=1
    0x36d8a5664f10e410,  # i=2
    0x7f9458eaf7aef158,  # i=3
    0x6dc91b8e909374b8,  # i=4
    0x1924bba82746487,  # i=5
    0x3f877ac72c4a69cf,  # i=6
    0xba208d7d4baed121,  # i=7
    0x3a671c09ad17df90,  # i=8
    0x4e64758e60d4ce7d,  # i=9
    0x272117e2ef7e4a0e,  # i=10
    0xc7fe25fff7816603,  # i=11
    0xfbcbc462d6829b47,  # i=12
    0xdb4d9fb3c9f2c26d,  # i=13
    0xd3d18fd9a797fa8b,  # i=14
    0x5d49eeb1faf97c5e,  # i=15
    0xcf41ce7de294a4ba,  # i=16
    0x9afed7ec47e35742,  # i=17
    0x1580cc11bf1edaea,  # i=18
    0xfc33ef0826bd0d87,  # i=19
]

const S = MFloat128[
    MFloat128(0x0, 0x0, 128, 0),  # 0
    MFloat128(0xc90fc5f66525d257, 0x480f7956b6470765, -8, 0),  # 1
    MFloat128(0xc90f87f3380388d5, 0xcb3ff35bd4d81baa, -7, 0),  # 2
    MFloat128(0x96cb587284b81770, 0xb767005691b9d9d1, -6, 0),  # 3
    MFloat128(0xc90e8fe6f63c2330, 0xf1d7d06db39ea9fc, -6, 0),  # 4
    MFloat128(0xfb514b55ccbe541a, 0xd784e031f9af76d6, -6, 0),  # 5
    MFloat128(0x96c9b5df1877e9b5, 0xf91ee371d6467dca, -5, 0),  # 6
    MFloat128(0xafea690fd5912ef3, 0xf56e3c87ae3c56df, -5, 0),  # 7
    MFloat128(0xc90aafbd1b33efc9, 0xc539edcbfda0cf2c, -5, 0),  # 8
    MFloat128(0xe22a7a6729d8e453, 0x850021e392744a4f, -5, 0),  # 9
    MFloat128(0xfb49b98e8e7807f6, 0xb21ccebc9caac3, -5, 0),  # 10
    MFloat128(0x8a342eda160bf5ae, 0xde5b1068d174be9c, -4, 0),  # 11
    MFloat128(0x96c32baca2ae68b4, 0x37b2dd49d5fca3c0, -4, 0),  # 12
    MFloat128(0xa351cb7fc30bc889, 0xb56007d16d4ad5a3, -4, 0),  # 13
    MFloat128(0xafe00694866a1b44, 0xcd34d2751c2e1da7, -4, 0),  # 14
    MFloat128(0xbc6dd52c3a342eb5, 0xf10bfca3d6464012, -4, 0),  # 15
    MFloat128(0xc8fb2f886ec09f37, 0x6a17954b2b7c5171, -4, 0),  # 16
    MFloat128(0xd5880deafc18b534, 0x73d1472472f4a390, -4, 0),  # 17
    MFloat128(0xe214689606bf1676, 0x438b4a73aecd2541, -4, 0),  # 18
    MFloat128(0xeea037cc04764844, 0xc4e92d01a2f42935, -4, 0),  # 19
    MFloat128(0xfb2b73cfc106ff68, 0xf0a0e36a000c7350, -4, 0),  # 20
    MFloat128(0x83db0a7231831d8f, 0x60e782313f6161af, -3, 0),  # 21
    MFloat128(0x8a2009a6b84d9402, 0x77724a2b2a669bc4, -3, 0),  # 22
    MFloat128(0x9064b3a76a22640c, 0x56e0a8b0d177b55d, -3, 0),  # 23
    MFloat128(0x96a9049670cfae65, 0xf77574094d3c35c4, -3, 0),  # 24
    MFloat128(0x9cecf8962d14c822, 0x50ffe4f5caa7f1fa, -3, 0),  # 25
    MFloat128(0xa3308bc93904ad69, 0xdec1b7f2768bdafa, -3, 0),  # 26
    MFloat128(0xa973ba526a6850d9, 0x76f8c63986598c79, -3, 0),  # 27
    MFloat128(0xafb68054d520c60b, 0xfdd2fc0936594c2d, -3, 0),  # 28
    MFloat128(0xb5f8d9f3cd8945d6, 0x924bef13600f9852, -3, 0),  # 29
    MFloat128(0xbc3ac352ead90abe, 0xeb13e106732687f1, -3, 0),  # 30
    MFloat128(0xc27c389609850433, 0xb228a03916371f6f, -3, 0),  # 31
    MFloat128(0xc8bd35e14da15f0e, 0xc7396c894bbf7389, -3, 0),  # 32
    MFloat128(0xcefdb7592542e1e9, 0x6b47b8c44e5b037e, -3, 0),  # 33
    MFloat128(0xd53db9224ae01bca, 0x7337412cf70716cb, -3, 0),  # 34
    MFloat128(0xdb7d3761c7b263b6, 0xbb286d23e11c8337, -3, 0),  # 35
    MFloat128(0xe1bc2e3cf616a7ac, 0x31883b30137c6e62, -3, 0),  # 36
    MFloat128(0xe7fa99d983ee098f, 0xeeb8f9c33340a2f2, -3, 0),  # 37
    MFloat128(0xee38765d74fe4897, 0xed16b994af6c18ae, -3, 0),  # 38
    MFloat128(0xf475bfef2551f5b9, 0x14e1a5488eaeab96, -3, 0),  # 39
    MFloat128(0xfab272b54b9871a2, 0x704729ae56d78a37, -3, 0),  # 40
    MFloat128(0x8077456b7dc2d967, 0x3eac8308f1113e5e, -2, 0),  # 41
    MFloat128(0x8395023dd418e919, 0xdb1f70118c9c2198, -2, 0),  # 42
    MFloat128(0x86b26de5933c2e8e, 0xc5a9decdfaad4db5, -2, 0),  # 43
    MFloat128(0x89cf8676d7abb55b, 0x97965c9860c34e44, -2, 0),  # 44
    MFloat128(0x8cec4a05f12739e8, 0xdcdca90cc73b116a, -2, 0),  # 45
    MFloat128(0x9008b6a763de75b7, 0xa6e3df5975cca9da, -2, 0),  # 46
    MFloat128(0x9324ca6fe9a04b4e, 0x899c4de737feec22, -2, 0),  # 47
    MFloat128(0x964083747309d113, 0xa89a11e07c1fe, -2, 0),  # 48
    MFloat128(0x995bdfca28b53a54, 0x49c4863de522b217, -2, 0),  # 49
    MFloat128(0x9c76dd866c689dcc, 0xe7bc08111d0bfca4, -2, 0),  # 50
    MFloat128(0x9f917abeda4498df, 0xf3ff913a4aadb85e, -2, 0),  # 51
    MFloat128(0xa2abb58949f2ced7, 0xa5dbee6084ee1260, -2, 0),  # 52
    MFloat128(0xa5c58bfbcfd4436a, 0x69fcb11e19f58619, -2, 0),  # 53
    MFloat128(0xa8defc2cbe2f8fcc, 0xcd12a1f6ab6b095, -2, 0),  # 54
    MFloat128(0xabf80432a65ef190, 0x8c95c4c91179176b, -2, 0),  # 55
    MFloat128(0xaf10a22459fe32a6, 0x3feef3bb58b1f10d, -2, 0),  # 56
    MFloat128(0xb228d418ec1869ad, 0x16031a34d4fc855d, -2, 0),  # 57
    MFloat128(0xb5409827b25591f0, 0xcd73fb5d8d45d302, -2, 0),  # 58
    MFloat128(0xb857ec684627fa4c, 0x187e26d290714d70, -2, 0),  # 59
    MFloat128(0xbb6ecef285f98a3a, 0xbddd8a0365d6b1d3, -2, 0),  # 60
    MFloat128(0xbe853dde9658dc60, 0xdfe1b074e22fc666, -2, 0),  # 61
    MFloat128(0xc19b3744e3262dcd, 0xad5a41de48f6b26f, -2, 0),  # 62
    MFloat128(0xc4b0b93e20c0213f, 0xdab4e426409b23a0, -2, 0),  # 63
    MFloat128(0xc7c5c1e34d3055b2, 0x5cc8c00e4fccd850, -2, 0),  # 64
    MFloat128(0xcada4f4db157cf77, 0xfa6171200ab2efc3, -2, 0),  # 65
    MFloat128(0xcdee5f96e21b332c, 0x65a3132adfb7dfd5, -2, 0),  # 66
    MFloat128(0xd101f0d8c18ed1c1, 0xaadb580a1eba209f, -2, 0),  # 67
    MFloat128(0xd415012d802284f0, 0xdf4005ef6a64aa02, -2, 0),  # 68
    MFloat128(0xd7278eaf9dcd5b55, 0x1779df36d1cc8912, -2, 0),  # 69
    MFloat128(0xda399779eb391377, 0xcbabaeb97af8e8aa, -2, 0),  # 70
    MFloat128(0xdd4b19a78aed6515, 0xece7f445cecf1e28, -2, 0),  # 71
    MFloat128(0xe05c1353f27b17e5, 0xebc61ade6ca83cd, -2, 0),  # 72
    MFloat128(0xe36c829aeba6e720, 0x26a0eecdb4f16266, -2, 0),  # 73
    MFloat128(0xe67c659895943123, 0x82b0aecadf808123, -2, 0),  # 74
    MFloat128(0xe98bba6965ef725f, 0xb91caf23416e7e80, -2, 0),  # 75
    MFloat128(0xec9a7f2a2a188aeb, 0x7244ee20f591983b, -2, 0),  # 76
    MFloat128(0xefa8b1f8084ccdfc, 0x1050cdf22f34182f, -2, 0),  # 77
    MFloat128(0xf2b650f080d0da8d, 0x587f3fa044e2d27d, -2, 0),  # 78
    MFloat128(0xf5c35a316f1a3c80, 0x643720de93ba81bd, -2, 0),  # 79
    MFloat128(0xf8cfcbd90af8d57a, 0x4221dc4ba772598d, -2, 0),  # 80
    MFloat128(0xfbdba405e9c00cca, 0xd24d3023da491920, -2, 0),  # 81
    MFloat128(0xfee6e0d6ff6fc5a4, 0x8b74fe2508ab8fc2, -2, 0),  # 82
    MFloat128(0x80f8c035cfee8d76, 0xfd958d68e8b49e6b, -1, 0),  # 83
    MFloat128(0x827dc071bfed6ffa, 0xfb4c92369f0cf008, -1, 0),  # 84
    MFloat128(0x8402702f5b30f2a9, 0xcb07b25a7b0372a7, -1, 0),  # 85
    MFloat128(0x8586ce7ededc809d, 0x9d3dc689006896f4, -1, 0),  # 86
    MFloat128(0x870ada70ba4e6d49, 0x9d52755ece3f70, -1, 0),  # 87
    MFloat128(0x888e93158fb3bb04, 0x984156f553344306, -1, 0),  # 88
    MFloat128(0x8a11f77e349bc245, 0xa66d1d936c38c329, -1, 0),  # 89
    MFloat128(0x8b9506bbb28bb922, 0x575f33366be0afef, -1, 0),  # 90
    MFloat128(0x8d17bfdf47921ac8, 0xcb590d74f64e77c9, -1, 0),  # 91
    MFloat128(0x8e9a21fa66d9ee8d, 0xf2be3ecae62789d4, -1, 0),  # 92
    MFloat128(0x901c2c1eb93dee39, 0x632b9cff5cfee724, -1, 0),  # 93
    MFloat128(0x919ddd5e1ddb8b33, 0x609c464b3dd676ec, -1, 0),  # 94
    MFloat128(0x931f34caaaa5d23a, 0x6a1ff8bfe6396e28, -1, 0),  # 95
    MFloat128(0x94a03176acf82d45, 0xae4ba773da6bf754, -1, 0),  # 96
    MFloat128(0x9620d274aa290339, 0xe06a955a5b8e301d, -1, 0),  # 97
    MFloat128(0x97a116d7601c3515, 0xfc8b7184b21f2d50, -1, 0),  # 98
    MFloat128(0x9920fdb1c5d5783d, 0x9dd1eedf18a2e4df, -1, 0),  # 99
    MFloat128(0x9aa086170c0a8d86, 0x9ffa0d23f3c26c62, -1, 0),  # 100
    MFloat128(0x9c1faf1a9db554af, 0xdab6b478577e7be5, -1, 0),  # 101
    MFloat128(0x9d9e77d020a5bbe6, 0xdb895384528d0d60, -1, 0),  # 102
    MFloat128(0x9f1cdf4b76138b02, 0x98dbd3555ebcdefe, -1, 0),  # 103
    MFloat128(0xa09ae4a0bb300a19, 0x2f895f44a303cc0b, -1, 0),  # 104
    MFloat128(0xa21886e449b78316, 0xd29d23a624acd00c, -1, 0),  # 105
    MFloat128(0xa395c52ab8829dfc, 0x2be036401ba87cc2, -1, 0),  # 106
    MFloat128(0xa5129e88dc17976a, 0x82d9495ead5be348, -1, 0),  # 107
    MFloat128(0xa68f1213c73b5124, 0x17218792857f4c5a, -1, 0),  # 108
    MFloat128(0xa80b1ee0cb823c27, 0x3269f4702b88324a, -1, 0),  # 109
    MFloat128(0xa986c40579e11c0a, 0x8e3bdf8085321556, -1, 0),  # 110
    MFloat128(0xab020097a33da341, 0xc1654b64a0081b46, -1, 0),  # 111
    MFloat128(0xac7cd3ad58fee7f0, 0x811f953984eff83e, -1, 0),  # 112
    MFloat128(0xadf73c5ced9db0f3, 0x9a5318ac6fe94e4d, -1, 0),  # 113
    MFloat128(0xaf7139bcf5349ac6, 0x9fe5f4ea48965e2c, -1, 0),  # 114
    MFloat128(0xb0eacae4461013ed, 0x63c66682bae74898, -1, 0),  # 115
    MFloat128(0xb263eee9f93e3088, 0x695a5332090bb09b, -1, 0),  # 116
    MFloat128(0xb3dca4e56b1e54bb, 0x992d96e5021e3c37, -1, 0),  # 117
    MFloat128(0xb554ebee3bf0b58e, 0x971f4da709ad4378, -1, 0),  # 118
    MFloat128(0xb6ccc31c5065afee, 0x35ebacd79f209137, -1, 0),  # 119
    MFloat128(0xb8442987d22cf576, 0x9cc3ef36746de3b8, -1, 0),  # 120
    MFloat128(0xb9bb1e4930848ead, 0xcdb0531c4e58484b, -1, 0),  # 121
    MFloat128(0xbb31a07920c7b256, 0x55b92083658bb897, -1, 0),  # 122
    MFloat128(0xbca7af309efd7182, 0xa4b0d21fc5036a5, -1, 0),  # 123
    MFloat128(0xbe1d4988ee67380c, 0xd1f90f79f46c7e01, -1, 0),  # 124
    MFloat128(0xbf926e9b9a0f2127, 0x91a1b5eb79658c67, -1, 0),  # 125
    MFloat128(0xc1071d8275561f9b, 0x721853f8e528a934, -1, 0),  # 126
    MFloat128(0xc27b55579c81f96d, 0xcdc2bd470675104d, -1, 0),  # 127
    MFloat128(0xc3ef1535754b168d, 0x3122c2a59efddc37, -1, 0),  # 128
    MFloat128(0xc5625c36af6a222f, 0xf4ff2895ab6ebe89, -1, 0),  # 129
    MFloat128(0xc6d5297645257e8d, 0x14d24739de27e2e9, -1, 0),  # 130
    MFloat128(0xc8477c0f7bde8a98, 0x4ce0246ad4fa74, -1, 0),  # 131
    MFloat128(0xc9b9531de49eb968, 0x4319e5ad5b0dcb84, -1, 0),  # 132
    MFloat128(0xcb2aadbd5ca47af5, 0xfaa3dfe675a65ee2, -1, 0),  # 133
    MFloat128(0xcc9b8b0a0deff5d4, 0x2e663b3c7555a6c3, -1, 0),  # 134
    MFloat128(0xce0bea206fcf9192, 0x3c540a9eec47af38, -1, 0),  # 135
    MFloat128(0xcf7bca1d476c516d, 0xa81290bdbaad62e4, -1, 0),  # 136
    MFloat128(0xd0eb2a1da855fefd, 0xb9302788604e88f1, -1, 0),  # 137
    MFloat128(0xd25a093ef50f2482, 0x721fc87ba1d42456, -1, 0),  # 138
    MFloat128(0xd3c8669edf98d680, 0x87967926fdcecec4, -1, 0),  # 139
    MFloat128(0xd536415b69fe4c54, 0x1df22346611c6b4b, -1, 0),  # 140
    MFloat128(0xd6a39892e6e04764, 0x3090d44db12c418c, -1, 0),  # 141
    MFloat128(0xd8106b63fa0048a0, 0xa573f2aa90434ba5, -1, 0),  # 142
    MFloat128(0xd97cb8ed98cb93f5, 0x2e349483e3fb2a6a, -1, 0),  # 143
    MFloat128(0xdae8804f0ae6015b, 0x362cb974182e3030, -1, 0),  # 144
    MFloat128(0xdc53c0a7eab49b35, 0x3ccca3982328ed8b, -1, 0),  # 145
    MFloat128(0xddbe791825e8099e, 0x1a5bd9269d408d7e, -1, 0),  # 146
    MFloat128(0xdf28a8bffe06ca56, 0xcce2634be2bf54df, -1, 0),  # 147
    MFloat128(0xe0924ec008f734fd, 0x8aa895d5bf3e84ea, -1, 0),  # 148
    MFloat128(0xe1fb6a3931894b38, 0xf7a1f9bd9ba13b6b, -1, 0),  # 149
    MFloat128(0xe363fa4cb8005482, 0x7b32c72e31824e51, -1, 0),  # 150
    MFloat128(0xe4cbfe1c329c453a, 0xd40e9e6b989f89e5, -1, 0),  # 151
    MFloat128(0xe63374c98e22f0b4, 0x2872ce1bfc7ad1cd, -1, 0),  # 152
    MFloat128(0xe79a5d770e6905dc, 0xf1b65cc5fd780262, -1, 0),  # 153
    MFloat128(0xe900b7474edad637, 0x431626c10485bdda, -1, 0),  # 154
    MFloat128(0xea66815d4304e6c8, 0xcc39cfcc29960b1, -1, 0),  # 155
    MFloat128(0xebcbbadc371c4aaa, 0x1d90f780ae951140, -1, 0),  # 156
    MFloat128(0xed3062e7d086c6f0, 0xc71debc372b6f9d4, -1, 0),  # 157
    MFloat128(0xee9478a40e62bf86, 0x2a24164daec85ccb, -1, 0),  # 158
    MFloat128(0xeff7fb354a0eecb1, 0x527233b40d3432bb, -1, 0),  # 159
    MFloat128(0xf15ae9c037b1d8f0, 0x6c48e9e3420b0f1e, -1, 0),  # 160
    MFloat128(0xf2bd4369e6c126d3, 0x7f232aee178c6323, -1, 0),  # 161
    MFloat128(0xf41f0757c2889e84, 0x3c7f10db458c337c, -1, 0),  # 162
    MFloat128(0xf58034af92b102a7, 0x93fa6107c4327527, -1, 0),  # 163
    MFloat128(0xf6e0ca977bc6ac45, 0xe1079824233fef46, -1, 0),  # 164
    MFloat128(0xf840c835ffbfed66, 0xa9a56012067c570c, -1, 0),  # 165
    MFloat128(0xf9a02cb1fe833a0d, 0x8da894471de1a18, -1, 0),  # 166
    MFloat128(0xfafef732b66d1742, 0x343fbf4a7d42af3, -1, 0),  # 167
    MFloat128(0xfc5d26dfc4d5cfda, 0x27c07c911290b8d1, -1, 0),  # 168
    MFloat128(0xfdbabae12696eea4, 0x2377c3799c052fa, -1, 0),  # 169
    MFloat128(0xff17b25f38907dad, 0xa9c6ba50490539f, -1, 0),  # 170
    MFloat128(0x803a06415c170525, 0x6f53873e2f1477ff, 0, 0),  # 171
    MFloat128(0x80e7e43a61f5b6cb, 0x5ca183dc973abc22, 0, 0),  # 172
    MFloat128(0x819572af6decac84, 0x9fba97fdf0c4d24c, 0, 0),  # 173
    MFloat128(0x8242b1357110d372, 0x6fb2123fedfa6e22, 0, 0),  # 174
    MFloat128(0x82ef9f618dc5b70e, 0x91a965931f1a200a, 0, 0),  # 175
    MFloat128(0x839c3cc917ff6cb4, 0xbfd79717f2880abf, 0, 0),  # 176
    MFloat128(0x8448890195846099, 0x246efcff30cb064a, 0, 0),  # 177
    MFloat128(0x84f483a0be2f0403, 0x51917cac857fd5f5, 0, 0),  # 178
    MFloat128(0x85a02c3c7c2f5ca5, 0x327888fe4b62687b, 0, 0),  # 179
    MFloat128(0x864b826aec4c74e5, 0x85043222c9bdd18d, 0, 0),  # 180
    MFloat128(0x86f685c25e25acf5, 0x7e0b9b07548471a2, 0, 0),  # 181
    MFloat128(0x87a135d95473ec89, 0x4e091160e2430712, 0, 0),  # 182
    MFloat128(0x884b9246854ab50b, 0x4f14c8afe4560291, 0, 0),  # 183
    MFloat128(0x88f59aa0da591421, 0xb892ca8361d8c84c, 0, 0),  # 184
    MFloat128(0x899f4e7f712a765e, 0xc88302a31afce54a, 0, 0),  # 185
    MFloat128(0x8a48ad799b6759f3, 0x660558a02136130a, 0, 0),  # 186
    MFloat128(0x8af1b726df15e13c, 0x545f7d79ead8fa19, 0, 0),  # 187
    MFloat128(0x8b9a6b1ef6da4502, 0x21a6675f51580bc4, 0, 0),  # 188
    MFloat128(0x8c42c8f9d2372644, 0x101a5adbcb9ffb43, 0, 0),  # 189
    MFloat128(0x8cead04f95cdbf66, 0x4d49cbaf15aecd80, 0, 0),  # 190
    MFloat128(0x8d9280b89b9df49b, 0xde2d43c6b67a7cbe, 0, 0),  # 191
    MFloat128(0x8e39d9cd73464364, 0xbba4cfecbff54867, 0, 0),  # 192
    MFloat128(0x8ee0db26e24390f8, 0xaf0e2345f3bd24b4, 0, 0),  # 193
    MFloat128(0x8f87845de430d777, 0x9311a82459aa0f72, 0, 0),  # 194
    MFloat128(0x902dd50bab06b1b7, 0xb144016c7a30b39a, 0, 0),  # 195
    MFloat128(0x90d3ccc99f5ac58b, 0x9d1072e09b72292, 0, 0),  # 196
    MFloat128(0x91796b31609f0c54, 0x6714fe6925b78cc4, 0, 0),  # 197
    MFloat128(0x921eafdcc560f9c5, 0x33d0a284a8c954ad, 0, 0),  # 198
    MFloat128(0x92c39a65db88809d, 0x1f8481e704e4a767, 0, 0),  # 199
    MFloat128(0x93682a66e896f544, 0xb17821911e71c16e, 0, 0),  # 200
    MFloat128(0x940c5f7a69e5ce1c, 0x1489a97671a42, 0, 0),  # 201
    MFloat128(0x94b0393b14e54156, 0xd6c7af02d5c16fd9, 0, 0),  # 202
    MFloat128(0x9553b743d75ac03f, 0xac0106650f4ef023, 0, 0),  # 203
    MFloat128(0x95f6d92fd79f4fba, 0xd9f8e1a446e973b9, 0, 0),  # 204
    MFloat128(0x96999e9a74ddbde3, 0xa7a7556c3b33abc1, 0, 0),  # 205
    MFloat128(0x973c071f4750b49c, 0xc0a03934f0cce19b, 0, 0),  # 206
    MFloat128(0x97de125a2080a8ed, 0xd243aa0843a2c144, 0, 0),  # 207
    MFloat128(0x987fbfe70b81a708, 0x19cec845ac87a5c6, 0, 0),  # 208
    MFloat128(0x99210f624d30facb, 0xc4b992a37fb9b9bd, 0, 0),  # 209
    MFloat128(0x99c200686472b4a8, 0x1ab42d43235757b6, 0, 0),  # 210
    MFloat128(0x9a6292960a6f0ab0, 0x7e92c655656e6b85, 0, 0),  # 211
    MFloat128(0x9b02c58832cf95c0, 0x698b94f50326a043, 0, 0),  # 212
    MFloat128(0x9ba298dc0bfc6a88, 0x9a5614e8ffbeac6f, 0, 0),  # 213
    MFloat128(0x9c420c2eff590e5f, 0xc7fd954194e6d8aa, 0, 0),  # 214
    MFloat128(0x9ce11f1eb18147b1, 0x3e93627de8fd5779, 0, 0),  # 215
    MFloat128(0x9d7fd1490285c9e3, 0xe25e39549638ae68, 0, 0),  # 216
    MFloat128(0x9e1e224c0e28bc94, 0x2cad377d5c9c35d8, 0, 0),  # 217
    MFloat128(0x9ebc11c62c1a1dfb, 0xcc141e10c6460c8b, 0, 0),  # 218
    MFloat128(0x9f599f55f0340061, 0xa88d5f46834bbf8d, 0, 0),  # 219
    MFloat128(0x9ff6ca9a2ab6a26d, 0x22cc118a0c118aa0, 0, 0),  # 220
    MFloat128(0xa0939331e8846237, 0x7cec6df5bea167cf, 0, 0),  # 221
    MFloat128(0xa12ff8bc735d8af6, 0x71acea2819360c35, 0, 0),  # 222
    MFloat128(0xa1cbfad9521bfd1b, 0x166c36e7bb3c402f, 0, 0),  # 223
    MFloat128(0xa267992848eeb0c0, 0x3b5167ee359a234e, 0, 0),  # 224
    MFloat128(0xa302d34959951243, 0x9443372e20d4377c, 0, 0),  # 225
    MFloat128(0xa39da8dcc39a38e5, 0xca9a8a720d4c69c, 0, 0),  # 226
    MFloat128(0xa4381983048ff747, 0xbf623cf5301a2dde, 0, 0),  # 227
    MFloat128(0xa4d224dcd849c5b0, 0x23d251cc8d7975cc, 0, 0),  # 228
    MFloat128(0xa56bca8b391785db, 0x189d39ffe11aaa2b, 0, 0),  # 229
    MFloat128(0xa6050a2f60002049, 0x8c33ebf3aa8501fb, 0, 0),  # 230
    MFloat128(0xa69de36ac4fbfadc, 0x9b3ad6e4022183d9, 0, 0),  # 231
    MFloat128(0xa73655df1f2f489e, 0x149f6e75993468a3, 0, 0),  # 232
    MFloat128(0xa7ce612e65243291, 0x6b2a39f856a69781, 0, 0),  # 233
    MFloat128(0xa86604facd04d969, 0x3463a2c2e6e9cc55, 0, 0),  # 234
    MFloat128(0xa8fd40e6ccd52ffd, 0x6cc14c4f53e2e82d, 0, 0),  # 235
    MFloat128(0xa99414951aacae5e, 0xd147625fda929af8, 0, 0),  # 236
    MFloat128(0xaa2a7fa8acefdd63, 0xb714ee81b53b4b9d, 0, 0),  # 237
    MFloat128(0xaac081c4ba89ba8a, 0xe1b3dfc4dbda9bfd, 0, 0),  # 238
    MFloat128(0xab561a8cbb24f410, 0xf17cee69b0d2ecde, 0, 0),  # 239
    MFloat128(0xabeb49a46764fd15, 0x1becda8089c1a94c, 0, 0),  # 240
    MFloat128(0xac800eafb91ef9a9, 0xf86ba0dde982fb59, 0, 0),  # 241
    MFloat128(0xad146952eb9282af, 0x44bf16268608db96, 0, 0),  # 242
    MFloat128(0xada859327ba24151, 0x9d30d4cfeb04f1fb, 0, 0),  # 243
    MFloat128(0xae3bddf3280c620d, 0x3d53817865422565, 0, 0),  # 244
    MFloat128(0xaecef739f1a2df10, 0xf74d099042e8f326, 0, 0),  # 245
    MFloat128(0xaf61a4ac1b83a1de, 0xa89a9b8f726b95bf, 0, 0),  # 246
    MFloat128(0xaff3e5ef2b507c06, 0x8c679e67fc462d51, 0, 0),  # 247
    MFloat128(0xb085baa8e966f6da, 0xe4cad00d5c94bcd2, 0, 0),  # 248
    MFloat128(0xb117227f6117f9f9, 0x8d8be132d576e614, 0, 0),  # 249
    MFloat128(0xb1a81d18e0df4889, 0x24784f32c3e3e5bd, 0, 0),  # 250
    MFloat128(0xb238aa1bfa9ad507, 0x8cc7d4bd05ffd5ae, 0, 0),  # 251
    MFloat128(0xb2c8c92f83c1eb87, 0xac9f7ebbc469ef59, 0, 0),  # 252
    MFloat128(0xb35879fa959c323c, 0x5d6635109164f740, 0, 0),  # 253
    MFloat128(0xb3e7bc248d78802e, 0xa156468ef6c18c60, 0, 0),  # 254
    MFloat128(0xb4768f550ce389fd, 0x4a85350f69018c55, 0, 0),  # 255
]

const C = MFloat128[
    MFloat128(0x8000000000000000, 0x0, 1, 0),  # 0
    MFloat128(0xffffb10b10e80e95, 0x3031437d7eccb9df, 0, 0),  # 1
    MFloat128(0xfffec42c7454926b, 0x38e310779edfec68, 0, 0),  # 2
    MFloat128(0xfffd3964bc6275ba, 0x69fff9ae0dedb047, 0, 0),  # 3
    MFloat128(0xfffb10b4dc96dabb, 0xb47903f7a19f8ee2, 0, 0),  # 4
    MFloat128(0xfff84a1e29de8571, 0x8cc193c5d508e13f, 0, 0),  # 5
    MFloat128(0xfff4e5a25a8d095b, 0x43366df666fd54ff, 0, 0),  # 6
    MFloat128(0xfff0e343865bbb13, 0x5428ed0647c9e5d1, 0, 0),  # 7
    MFloat128(0xffec4304266865d9, 0x5657552366961732, 0, 0),  # 8
    MFloat128(0xffe704e71533c508, 0x53aa9423bb0adc21, 0, 0),  # 9
    MFloat128(0xffe128ef8e9fc17a, 0x7d209f32d42d864e, 0, 0),  # 10
    MFloat128(0xffdaaf212fed72db, 0x4fd8f038449ec436, 0, 0),  # 11
    MFloat128(0xffd3977ff7bae4e9, 0x664649b4d541b9c5, 0, 0),  # 12
    MFloat128(0xffcbe2104600a0a9, 0x5595ca3f421ae09c, 0, 0),  # 13
    MFloat128(0xffc38ed6dc0ef98b, 0x1c676208aa3be545, 0, 0),  # 14
    MFloat128(0xffba9dd8dc8b1e83, 0xccfed60a91097c48, 0, 0),  # 15
    MFloat128(0xffb10f1bcb6bef1d, 0x421e8edaaf59453e, 0, 0),  # 16
    MFloat128(0xffa6e2a58df6947d, 0xd2c665c2da3e7844, 0, 0),  # 17
    MFloat128(0xff9c187c6abade6a, 0x1e1862cca089938b, 0, 0),  # 18
    MFloat128(0xff90b0a7098f6443, 0x2dabd3195a05710f, 0, 0),  # 19
    MFloat128(0xff84ab2c738d6a03, 0x519c314973ccae6b, 0, 0),  # 20
    MFloat128(0xff780814130c893c, 0x3ea4f30adda3016f, 0, 0),  # 21
    MFloat128(0xff6ac765b39e1e19, 0x1b9d5851979f28fb, 0, 0),  # 22
    MFloat128(0xff5ce92982087867, 0x50a7bb6a6ee3b0f1, 0, 0),  # 23
    MFloat128(0xff4e6d680c41d0a9, 0xf668633f1ab858a, 0, 0),  # 24
    MFloat128(0xff3f542a416b0134, 0xb085c1828f69296a, 0, 0),  # 25
    MFloat128(0xff2f9d7971ca0364, 0x27e31939e2eec09c, 0, 0),  # 26
    MFloat128(0xff1f495f4ec430d7, 0xf5971326a3540ea9, 0, 0),  # 27
    MFloat128(0xff0e57e5ead848d1, 0x1f1901544271c3f8, 0, 0),  # 28
    MFloat128(0xfefcc917b99839a5, 0xe0abd3a9b64df725, 0, 0),  # 29
    MFloat128(0xfeea9cff8fa2ae54, 0xec34413e87ef2740, 0, 0),  # 30
    MFloat128(0xfed7d3a8a29c603b, 0x2f88b949a72ff96c, 0, 0),  # 31
    MFloat128(0xfec46d1e89292cf0, 0x41390efdc726e9ef, 0, 0),  # 32
    MFloat128(0xfeb0696d3ae4f04d, 0xb7b6cc53c3abc817, 0, 0),  # 33
    MFloat128(0xfe9bc8a1105c22a5, 0xd3af6ee4f2101c20, 0, 0),  # 34
    MFloat128(0xfe868ac6c3043b2e, 0xb4f70c910505e10, 0, 0),  # 35
    MFloat128(0xfe70afeb6d33d6a2, 0x2907cf2b3f6feac2, 0, 0),  # 36
    MFloat128(0xfe5a381c8a1aa224, 0xd54faa364b7da8f6, 0, 0),  # 37
    MFloat128(0xfe432367f5b90a62, 0x87b8875373a818a4, 0, 0),  # 38
    MFloat128(0xfe2b71dbecd7aefc, 0x8598c2c429caf7, 0, 0),  # 39
    MFloat128(0xfe1323870cfe9a3d, 0x90cd1d959db674ef, 0, 0),  # 40
    MFloat128(0xfdfa3878546c3d28, 0x9bfe5c51e91cbdcd, 0, 0),  # 41
    MFloat128(0xfde0b0bf220c2fd4, 0xe276d247626a23fd, 0, 0),  # 42
    MFloat128(0xfdc68c6b356db62f, 0x499ddb331d19539d, 0, 0),  # 43
    MFloat128(0xfdabcb8caeba091b, 0xfac7397cc07a6470, 0, 0),  # 44
    MFloat128(0xfd906e340eaa6401, 0xd6e270740a186977, 0, 0),  # 45
    MFloat128(0xfd747472367dd6c5, 0x61beb8cd2696fc78, 0, 0),  # 46
    MFloat128(0xfd57de5867eedc39, 0x6c696582f346fd91, 0, 0),  # 47
    MFloat128(0xfd3aabf84528b50b, 0xeae6bd951c1dabbe, 0, 0),  # 48
    MFloat128(0xfd1cdd63d0bc8735, 0x863b87258f11ad7e, 0, 0),  # 49
    MFloat128(0xfcfe72ad6d9641f2, 0xa06fab9f9d106709, 0, 0),  # 50
    MFloat128(0xfcdf6be7def1464c, 0xa4e064308f4999f4, 0, 0),  # 51
    MFloat128(0xfcbfc926484cd43a, 0xa3e22b4d38917e73, 0, 0),  # 52
    MFloat128(0xfc9f8a7c2d603c60, 0x5d582cac7cb4391c, 0, 0),  # 53
    MFloat128(0xfc7eaffd720ed673, 0x2880268f2e62955, 0, 0),  # 54
    MFloat128(0xfc5d39be5a5bbc4b, 0x1c0d254b6c8da4bd, 0, 0),  # 55
    MFloat128(0xfc3b27d38a5d49ab, 0x256778ffcb5c1769, 0, 0),  # 56
    MFloat128(0xfc187a52063060c2, 0x9433b49289417ea2, 0, 0),  # 57
    MFloat128(0xfbf5314f31eb7375, 0x25aafd7fdba12c5f, 0, 0),  # 58
    MFloat128(0xfbd14ce0d191516e, 0x7190c94899dff1b8, 0, 0),  # 59
    MFloat128(0xfbaccd1d0903bb09, 0xe63ae8632b84473c, 0, 0),  # 60
    MFloat128(0xfb87b21a5bf5b917, 0x75df66f0ec3dd459, 0, 0),  # 61
    MFloat128(0xfb61fbefadddb985, 0x61ce9d5ef5a81487, 0, 0),  # 62
    MFloat128(0xfb3baab441e770f7, 0xb4b54683879c9c17, 0, 0),  # 63
    MFloat128(0xfb14be7fbae58156, 0x2172a361fd2a722f, 0, 0),  # 64
    MFloat128(0xfaed376a1b42e559, 0x2079880c450348ac, 0, 0),  # 65
    MFloat128(0xfac5158bc4f4211f, 0x4a188aa367f90ab1, 0, 0),  # 66
    MFloat128(0xfa9c58fd796837d4, 0x10655ecd5cc771d8, 0, 0),  # 67
    MFloat128(0xfa7301d859796671, 0x1fe196a53fb5b237, 0, 0),  # 68
    MFloat128(0xfa491035e55da3a3, 0xd24377c77a591e24, 0, 0),  # 69
    MFloat128(0xfa1e842ffc96e4e0, 0x431c393c7f62da65, 0, 0),  # 70
    MFloat128(0xf9f35de0dde328ab, 0xba5dbf4510eddc8f, 0, 0),  # 71
    MFloat128(0xf9c79d63272c4628, 0x4504ae08d19b2980, 0, 0),  # 72
    MFloat128(0xf99b42d1d57781eb, 0x78685d850f80ecdc, 0, 0),  # 73
    MFloat128(0xf96e4e4844d4e82a, 0x80e8c17bf80e8f02, 0, 0),  # 74
    MFloat128(0xf940bfe2304e6c45, 0xc0e2a1352ed7f292, 0, 0),  # 75
    MFloat128(0xf91297bbb1d6cdbe, 0x68fc6e4d6a920bd2, 0, 0),  # 76
    MFloat128(0xf8e3d5f1423842a0, 0x9701914c7f8fbcd7, 0, 0),  # 77
    MFloat128(0xf8b47a9fb902e76c, 0xac9f07f54ff5bc14, 0, 0),  # 78
    MFloat128(0xf88485e44c7af48a, 0xb36a9dfaadafc1e1, 0, 0),  # 79
    MFloat128(0xf853f7dc9186b952, 0xc7adc6b4988891bb, 0, 0),  # 80
    MFloat128(0xf822d0a67b9c5cb5, 0xa776175bd284fe05, 0, 0),  # 81
    MFloat128(0xf7f110605caf6390, 0xa76f7efc19aed41c, 0, 0),  # 82
    MFloat128(0xf7beb728e51dfcb8, 0x730785813f78aa1e, 0, 0),  # 83
    MFloat128(0xf78bc51f239e12c6, 0x214cffcee9dd33ca, 0, 0),  # 84
    MFloat128(0xf7583a62852a23b2, 0x4becad887680c197, 0, 0),  # 85
    MFloat128(0xf7241712d4edde49, 0xf99107e50d631330, 0, 0),  # 86
    MFloat128(0xf6ef5b503c328589, 0x50ca117eb18beed7, 0, 0),  # 87
    MFloat128(0xf6ba073b424b19e8, 0x2c791f59cc1ffc23, 0, 0),  # 88
    MFloat128(0xf6841af4cc8048a4, 0xce8c455197cdf8a7, 0, 0),  # 89
    MFloat128(0xf64d969e1dfc2119, 0x119d358de0493956, 0, 0),  # 90
    MFloat128(0xf6167a58d7b59026, 0x9dc7e5954c5a8f24, 0, 0),  # 91
    MFloat128(0xf5dec646f85ba1c6, 0xc8c615e72768d6b5, 0, 0),  # 92
    MFloat128(0xf5a67a8adc4088ca, 0xed0dd4bf62edd13f, 0, 0),  # 93
    MFloat128(0xf56d97473d446cda, 0x275a2bbb2bab6c8a, 0, 0),  # 94
    MFloat128(0xf5341c9f32bffeb9, 0x8da64484aaa0febc, 0, 0),  # 95
    MFloat128(0xf4fa0ab6316ed2ec, 0x163c5c7f03b718c5, 0, 0),  # 96
    MFloat128(0xf4bf61b00b5982b7, 0x890ac4aafa6a37bf, 0, 0),  # 97
    MFloat128(0xf48421b0efbf939b, 0xf8f9d3b87d11fd52, 0, 0),  # 98
    MFloat128(0xf4484add6b01254b, 0x667e06866c07c369, 0, 0),  # 99
    MFloat128(0xf40bdd5a6688662f, 0x5019794a1f5896e5, 0, 0),  # 100
    MFloat128(0xf3ced94d28b2ce8a, 0x18ef535a7ffa7a3d, 0, 0),  # 101
    MFloat128(0xf3913edb54ba2242, 0x50f29b4b49f31c37, 0, 0),  # 102
    MFloat128(0xf3530e2aea9d3966, 0xd981acdcf6bc3e4, 0, 0),  # 103
    MFloat128(0xf314476247088f74, 0xa5486bdc455d56a2, 0, 0),  # 104
    MFloat128(0xf2d4eaa8233e997d, 0x431be53f92ece9e6, 0, 0),  # 105
    MFloat128(0xf294f82394ffe320, 0xebadcdbf915e8f6c, 0, 0),  # 106
    MFloat128(0xf2546ffc0e72f286, 0xaf0eed81e8c51e55, 0, 0),  # 107
    MFloat128(0xf21352595e0bf350, 0xe7112e89103cc0c7, 0, 0),  # 108
    MFloat128(0xf1d19f63ae7428a2, 0x844e6a35ddc2b713, 0, 0),  # 109
    MFloat128(0xf18f574386712643, 0x8f6bac72988088b0, 0, 0),  # 110
    MFloat128(0xf14c7a21c8cbd0f4, 0x2730081c758fb42b, 0, 0),  # 111
    MFloat128(0xf1090827b43725fd, 0x67127db35b287316, 0, 0),  # 112
    MFloat128(0xf0c5017ee336ca0f, 0xc4e557b119ef3185, 0, 0),  # 113
    MFloat128(0xf08066514c055f7e, 0x973ea9903ed5125f, 0, 0),  # 114
    MFloat128(0xf03b36c9407aa3e8, 0x992d39ec5c561d28, 0, 0),  # 115
    MFloat128(0xeff573116df1555d, 0x62aef7b55319d1d4, 0, 0),  # 116
    MFloat128(0xefaf1b54dd2cdf0f, 0xf03a18a5e16ab641, 0, 0),  # 117
    MFloat128(0xef682fbef23ecda6, 0x767c0e8ad33bc085, 0, 0),  # 118
    MFloat128(0xef20b07b6c6c0b37, 0xe2398bf0eeb28cde, 0, 0),  # 119
    MFloat128(0xeed89db66611e307, 0x86f8c20fb664b01b, 0, 0),  # 120
    MFloat128(0xee8ff79c548acd0f, 0xa1d2c3d018a9279f, 0, 0),  # 121
    MFloat128(0xee46be5a0813016b, 0x7872773830d368be, 0, 0),  # 122
    MFloat128(0xedfcf21cabacd3b1, 0xfee6a1eebfa13b4a, 0, 0),  # 123
    MFloat128(0xedb29311c504d652, 0x11815196b9fbf5df, 0, 0),  # 124
    MFloat128(0xed67a1673455c601, 0x7289102076a125e5, 0, 0),  # 125
    MFloat128(0xed1c1d4b344c3d4f, 0xddffe98c4f8aa031, 0, 0),  # 126
    MFloat128(0xecd006ec59ea306f, 0xa8392eb238578ab0, 0, 0),  # 127
    MFloat128(0xec835e79946a3145, 0x7e610231ac1d6181, 0, 0),  # 128
    MFloat128(0xec3624222d227bd1, 0x278047ae3dd0889, 0, 0),  # 129
    MFloat128(0xebe85815c767cb00, 0x1e99ccb9adc62ca6, 0, 0),  # 130
    MFloat128(0xeb99fa84606ff5ff, 0xdae311e656e0661, 0, 0),  # 131
    MFloat128(0xeb4b0b9e4f345617, 0x39e39c6c2ab3655d, 0, 0),  # 132
    MFloat128(0xeafb8b944453f52f, 0x3383bbb5156bf1d7, 0, 0),  # 133
    MFloat128(0xeaab7a9749f584fe, 0x24db98ad3a0647a1, 0, 0),  # 134
    MFloat128(0xea5ad8d8c3a91f05, 0x4a0ca5ea449b1c83, 0, 0),  # 135
    MFloat128(0xea09a68a6e49cd62, 0x15ad45b4a1b5e823, 0, 0),  # 136
    MFloat128(0xe9b7e3de5fdedc8b, 0xcd24d4bd1056c826, 0, 0),  # 137
    MFloat128(0xe9659107077cf60f, 0x89a92b199adfbafa, 0, 0),  # 138
    MFloat128(0xe912ae372d27045d, 0xacb1c26a06e5ae02, 0, 0),  # 139
    MFloat128(0xe8bf3ba1f1aedfbb, 0xf8972affb3d98e1f, 0, 0),  # 140
    MFloat128(0xe86b397ace95c46f, 0x9fec1e78c4376186, 0, 0),  # 141
    MFloat128(0xe816a7f595ec9232, 0xbfe8378abfb87b6f, 0, 0),  # 142
    MFloat128(0xe7c187467233d508, 0xdbfb0fe56c6f80fe, 0, 0),  # 143
    MFloat128(0xe76bd7a1e63b9786, 0x125129529d48a92f, 0, 0),  # 144
    MFloat128(0xe715993ccd02fe9c, 0xe2ba81b9ce96e02e, 0, 0),  # 145
    MFloat128(0xe6becc4c5997af06, 0x82fcedb4c6434d76, 0, 0),  # 146
    MFloat128(0xe667710616f4fc59, 0xdd2a3e32c3859960, 0, 0),  # 147
    MFloat128(0xe60f879fe7e2e1e5, 0x7613b68f6ab03130, 0, 0),  # 148
    MFloat128(0xe5b7105006d4c560, 0x9b695cd67c93bd79, 0, 0),  # 149
    MFloat128(0xe55e0b4d05c80388, 0x5a7c210a3a15e7ea, 0, 0),  # 150
    MFloat128(0xe50478cdce2246bc, 0xe1f5a58c80292554, 0, 0),  # 151
    MFloat128(0xe4aa5909a08fa7b4, 0x122785ae67f5515d, 0, 0),  # 152
    MFloat128(0xe44fac3814e09856, 0x20d63b5b9e3cd6ac, 0, 0),  # 153
    MFloat128(0xe3f4729119e798d9, 0x56992551ae074e99, 0, 0),  # 154
    MFloat128(0xe398ac4cf556b732, 0xd1197dc12c63176, 0, 0),  # 155
    MFloat128(0xe33c59a4439cd8ec, 0x36563e2ffad8351a, 0, 0),  # 156
    MFloat128(0xe2df7acff7c2cf83, 0xd6fe4dd22e60a4a2, 0, 0),  # 157
    MFloat128(0xe28210095b483751, 0xfd39138aa2d508ed, 0, 0),  # 158
    MFloat128(0xe224198a0e002123, 0xe0521df01a1be6f5, 0, 0),  # 159
    MFloat128(0xe1c5978c05ed8691, 0xf4e8a8372f8c5810, 0, 0),  # 160
    MFloat128(0xe1668a498f1f892c, 0xe2f9d4600f4d0325, 0, 0),  # 161
    MFloat128(0xe106f1fd4b8d7c96, 0x6ba8a9d9ba877899, 0, 0),  # 162
    MFloat128(0xe0a6cee232f2bb9c, 0x6d6c98fe79817946, 0, 0),  # 163
    MFloat128(0xe046213392aa486c, 0x55ff6038a5197367, 0, 0),  # 164
    MFloat128(0xdfe4e92d0d8a37f5, 0x720588ff6547d884, 0, 0),  # 165
    MFloat128(0xdf83270a9bbee890, 0xab01350f013d78dd, 0, 0),  # 166
    MFloat128(0xdf20db088aa60404, 0x64a58b2f103485dd, 0, 0),  # 167
    MFloat128(0xdebe05637ca94cfb, 0x4b19aa71fec3ae6d, 0, 0),  # 168
    MFloat128(0xde5aa65869193805, 0x4248f15548f69ca, 0, 0),  # 169
    MFloat128(0xddf6be249c075037, 0xd597b10a01676659, 0, 0),  # 170
    MFloat128(0xdd924d05b620678a, 0x739c45b982193b5e, 0, 0),  # 171
    MFloat128(0xdd2d5339ac8692fd, 0x49c6e0ea76cbcaac, 0, 0),  # 172
    MFloat128(0xdcc7d0fec8aaf2aa, 0xb2069fd0b482b4e8, 0, 0),  # 173
    MFloat128(0xdc61c693a82745d5, 0xaca8017e375b64e5, 0, 0),  # 174
    MFloat128(0xdbfb34373c974b0e, 0xccb7fd40d543f4a1, 0, 0),  # 175
    MFloat128(0xdb941a28cb71ec87, 0x2c19b63253da43fc, 0, 0),  # 176
    MFloat128(0xdb2c78a7ede238a9, 0x5a98479cbef2ecbc, 0, 0),  # 177
    MFloat128(0xdac44ff490a02710, 0x5b267c1bcff0ab62, 0, 0),  # 178
    MFloat128(0xda5ba04ef3c929f4, 0xe257bde73d83dc1a, 0, 0),  # 179
    MFloat128(0xd9f269f7aab88c29, 0x28e81dcb6dab91ac, 0, 0),  # 180
    MFloat128(0xd988ad2f9bdf9bbb, 0xc4e4dc69fc2fff6f, 0, 0),  # 181
    MFloat128(0xd91e6a38009da15a, 0x1bb35ad6d2e74b67, 0, 0),  # 182
    MFloat128(0xd8b3a1526517a48b, 0x1ed1a8ff78f1b632, 0, 0),  # 183
    MFloat128(0xd84852c0a80ffcdb, 0x24b9fe00663574a4, 0, 0),  # 184
    MFloat128(0xd7dc7ec4fabdb011, 0xced12d2899b803db, 0, 0),  # 185
    MFloat128(0xd77025a1e0a39d8b, 0xcb78e80e67ba1b8, 0, 0),  # 186
    MFloat128(0xd703479a2f6776cc, 0x6cb3bfd65b38562b, 0, 0),  # 187
    MFloat128(0xd695e4f10ea88570, 0x83f082b570611d7, 0, 0),  # 188
    MFloat128(0xd627fde9f7d63e7e, 0x7afbefc05e9f7d99, 0, 0),  # 189
    MFloat128(0xd5b992c8b606a351, 0x7190b755535d4f18, 0, 0),  # 190
    MFloat128(0xd54aa3d165cc7018, 0x7d00ae97abaa4096, 0, 0),  # 191
    MFloat128(0xd4db3148750d1819, 0xf630e8b6dac83e69, 0, 0),  # 192
    MFloat128(0xd46b3b72a2d68fc9, 0xdc4663a3168698d2, 0, 0),  # 193
    MFloat128(0xd3fac294ff34e4d0, 0xb77d4f6bd0ee8591, 0, 0),  # 194
    MFloat128(0xd389c6f4eb07a41c, 0xa8faac741a6394dc, 0, 0),  # 195
    MFloat128(0xd31848d817d70e16, 0xeeeaddb72f00e0dd, 0, 0),  # 196
    MFloat128(0xd2a6488487a91918, 0x4300fd1c1ce507e5, 0, 0),  # 197
    MFloat128(0xd233c6408cd64236, 0x981ba7e42537275f, 0, 0),  # 198
    MFloat128(0xd1c0c252c9de2c86, 0xda7485a5aeffeb4c, 0, 0),  # 199
    MFloat128(0xd14d3d02313c0eed, 0x744fea20e8abef92, 0, 0),  # 200
    MFloat128(0xd0d93696053af098, 0x77a18eb13d2ecde5, 0, 0),  # 201
    MFloat128(0xd064af55d7c9b43e, 0x6b8a685f6cb61c21, 0, 0),  # 202
    MFloat128(0xcfefa7898a4ef23c, 0xdaf200dd81212d10, 0, 0),  # 203
    MFloat128(0xcf7a1f794d7ca1b1, 0xdfcb60445c1bf973, 0, 0),  # 204
    MFloat128(0xcf04176da12390ac, 0x4d27090f10c454e, 0, 0),  # 205
    MFloat128(0xce8d8faf5406ab8b, 0xf5babff66def7892, 0, 0),  # 206
    MFloat128(0xce16888783ae13b3, 0x93e391861a034684, 0, 0),  # 207
    MFloat128(0xcd9f023f9c3a059e, 0x23af31db7179a4aa, 0, 0),  # 208
    MFloat128(0xcd26fd2158358e7d, 0x649474e36b8db9d3, 0, 0),  # 209
    MFloat128(0xccae7976c0691177, 0x83e907fbd7aaf0b0, 0, 0),  # 210
    MFloat128(0xcc35778a2bac9ca1, 0xf839ce18e08bfb50, 0, 0),  # 211
    MFloat128(0xcbbbf7a63eba0dd5, 0x70cbb7f3343451be, 0, 0),  # 212
    MFloat128(0xcb41fa15ebff0777, 0x2293661be51140ab, 0, 0),  # 213
    MFloat128(0xcac77f24736eb553, 0xd9944be1631846d8, 0, 0),  # 214
    MFloat128(0xca4c871d625361a9, 0x5328edeb3e6784de, 0, 0),  # 215
    MFloat128(0xc9d1124c931fda7a, 0x8335241be1693225, 0, 0),  # 216
    MFloat128(0xc95520fe2d40a74b, 0x83b0e96e1249c2b0, 0, 0),  # 217
    MFloat128(0xc8d8b37ea4ed0f62, 0xb562c00b34ee771, 0, 0),  # 218
    MFloat128(0xc85bca1abaf7f0a7, 0x65862939b83382e0, 0, 0),  # 219
    MFloat128(0xc7de651f7ca06749, 0x2b31bc86877fd2c, 0, 0),  # 220
    MFloat128(0xc76084da43624634, 0xd5c149509e9059f1, 0, 0),  # 221
    MFloat128(0xc6e22998b4c6608e, 0xcfe6c1b1a6b4e2a4, 0, 0),  # 222
    MFloat128(0xc66353a8c232a43c, 0xe993503baf5afb41, 0, 0),  # 223
    MFloat128(0xc5e40358a8ba05a7, 0x43da25d99267326b, 0, 0),  # 224
    MFloat128(0xc56438f6f0ec3cca, 0xab4906075507e74, 0, 0),  # 225
    MFloat128(0xc4e3f4d26ea553b6, 0xdd40950cf1ed92fa, 0, 0),  # 226
    MFloat128(0xc463373a40dd06a3, 0x9dd768f30ca8e85c, 0, 0),  # 227
    MFloat128(0xc3e2007dd175f5a4, 0xa87e78136665cdb2, 0, 0),  # 228
    MFloat128(0xc36050ecd50ca830, 0x8ac9e1386e4cbabb, 0, 0),  # 229
    MFloat128(0xc2de28d74ac6628b, 0x74c8f010d986a9e0, 0, 0),  # 230
    MFloat128(0xc25b888d7c1fcd38, 0xb7041e9bc8c18b0d, 0, 0),  # 231
    MFloat128(0xc1d8705ffcbb6e90, 0xbdf0715cb8b20bd7, 0, 0),  # 232
    MFloat128(0xc154e09faa2ff69a, 0x17858573216e0a22, 0, 0),  # 233
    MFloat128(0xc0d0d99dabd65d44, 0x2bda5328933c854a, 0, 0),  # 234
    MFloat128(0xc04c5bab7297d322, 0x6dd06968e0ed1957, 0, 0),  # 235
    MFloat128(0xbfc7671ab8bb84c6, 0xe4e62d86dd136e78, 0, 0),  # 236
    MFloat128(0xbf41fc3d81b430db, 0xd46655d6b012455, 0, 0),  # 237
    MFloat128(0xbebc1b6619ed9116, 0x2715ef03f8543355, 0, 0),  # 238
    MFloat128(0xbe35c4e716999630, 0x29d7f7b67d43b177, 0, 0),  # 239
    MFloat128(0xbdaef913557d76f0, 0xac85320f528d6d5d, 0, 0),  # 240
    MFloat128(0xbd27b83dfcbe9279, 0x2ea36923d5d8e213, 0, 0),  # 241
    MFloat128(0xbca002ba7aaf25ea, 0x4a48496734be336d, 0, 0),  # 242
    MFloat128(0xbc17d8dc859ad583, 0x727c405ffc73af56, 0, 0),  # 243
    MFloat128(0xbb8f3af81b93095c, 0xfce8d84068e825b6, 0, 0),  # 244
    MFloat128(0xbb062961823b1ddc, 0x5120e35e1c1a250c, 0, 0),  # 245
    MFloat128(0xba7ca46d46946802, 0x33201477347447d8, 0, 0),  # 246
    MFloat128(0xb9f2ac703cca0db3, 0x39db32d014440024, 0, 0),  # 247
    MFloat128(0xb96841bf7ffcb21a, 0x9de1e3b22b8bf4db, 0, 0),  # 248
    MFloat128(0xb8dd64b0720df647, 0xa726f4f0828585c9, 0, 0),  # 249
    MFloat128(0xb8521598bb6bce26, 0x1c041d1ea5fb3fdb, 0, 0),  # 250
    MFloat128(0xb7c654ce4adba9f2, 0x2e7a35723f3ed035, 0, 0),  # 251
    MFloat128(0xb73a22a755457448, 0x7f86f63bb23f496a, 0, 0),  # 252
    MFloat128(0xb6ad7f7a557e64f2, 0xeb2d28ef943dc88c, 0, 0),  # 253
    MFloat128(0xb6206b9e0c13a892, 0xea7c015f12b987f7, 0, 0),  # 254
    MFloat128(0xb592e7697f14dd4a, 0x737dd2824b608d13, 0, 0),  # 255
]

const PS = MFloat128[
    MFloat128(0xc90fdaa22168c234, 0xc4c6628b80dc1cd1, 3, 0),  # 0
    MFloat128(0xa55de7312df295f5, 0x5dc72f712aa57db4, 6, 1),  # 1
    MFloat128(0xa335e33bad570e92, 0x3f33be0021aa54d2, 7, 0),  # 2
    MFloat128(0x9969667315ec2d9d, 0xe59d6ab8509a2025, 7, 1),  # 3
    MFloat128(0xa83c1a43bf1c6485, 0x7d5f8f76fa7d74ed, 6, 0),  # 4
    MFloat128(0xf16ab2898eae62f9, 0xa7f0339113b8b3c5, 4, 1),  # 5
]

const PC = MFloat128[
    MFloat128(0x8000000000000000, 0x0, 1, 0),  # 0
    MFloat128(0x9de9e64df22ef2d2, 0x56e26cd9808c1949, 5, 1),  # 1
    MFloat128(0x81e0f840dad61d9a, 0x9980f00630cb655e, 7, 0),  # 2
    MFloat128(0xaae9e3f1e5ffcfe2, 0xa508509534006249, 7, 1),  # 3
    MFloat128(0xf0fa83448dd1e094, 0xe0603ce7044eeba, 6, 0),  # 4
    MFloat128(0xd368f6f4207cfe49, 0xec63157807ebffa, 5, 1),  # 5
]

# Fast-path sin polynomial coefficients
const PSfast = (
    0x1.921fb54442d18p+2,
    0x1.1a62645446203p-52,
    -0x1.4abbce625be53p5,
    0x1.466bc678d8d63p6,
    -0x1.331554ca19669p6,
)

# Fast-path cos polynomial coefficients
const PCfast = (
    0x1p+0,
    -0x1.923015cp-77,
    -0x1.3bd3cc9be45dep4,
    0x1.03c1f080ad892p6,
    -0x1.55a5c590f9e6ap6,
)

# Combined sin/cos table with correction: (xi_correction, sin, cos)
const SC = NTuple{3,Float64}[
    (0x0p+0, 0x0p+0, 0x1p+0),  # 0
    (-0x1.c0f6cp-35, 0x1.921f892b900fep-9, 0x1.ffff621623fap-1),  # 1
    (-0x1.9c7935ep-35, 0x1.921f0ea27ce01p-8, 0x1.fffd8858eca2ep-1),  # 2
    (-0x1.d14d1acp-34, 0x1.2d96af779b0bbp-7, 0x1.fffa72c986392p-1),  # 3
    (-0x1.dba8f6a8p-33, 0x1.921d1ce2d0a1cp-7, 0x1.fff62169dddaap-1),  # 4
    (0x1.a6b7cdfp-32, 0x1.f6a29bdb7377p-7, 0x1.fff0943c02419p-1),  # 5
    (0x1.b49618dp-33, 0x1.2d936d1506f3dp-6, 0x1.ffe9cb44829cp-1),  # 6
    (-0x1.398d6fcp-35, 0x1.5fd4d1e21de6dp-6, 0x1.ffe1c687174b1p-1),  # 7
    (-0x1.e9e9a8c8p-31, 0x1.9215597791e0ap-6, 0x1.ffd886097afcfp-1),  # 8
    (-0x1.34e844cp-32, 0x1.c454f2e9480c7p-6, 0x1.ffce09ce95933p-1),  # 9
    (-0x1.989a8a4p-32, 0x1.f693709b94f92p-6, 0x1.ffc251dfbac0cp-1),  # 10
    (0x1.04a9b99p-30, 0x1.146860e69a571p-5, 0x1.ffb55e40a5c43p-1),  # 11
    (-0x1.56947cp-36, 0x1.2d865748774adp-5, 0x1.ffa72efff95d1p-1),  # 12
    (-0x1.c348768p-35, 0x1.46a396d34121ap-5, 0x1.ff97c420a8451p-1),  # 13
    (0x1.9e80552p-32, 0x1.5fc00e6e4c65cp-5, 0x1.ff871dacd8761p-1),  # 14
    (0x1.3f11d74p-34, 0x1.78dbaa97099ebp-5, 0x1.ff753bb18af95p-1),  # 15
    (0x1.c039af4p-33, 0x1.91f65fc0abc0ap-5, 0x1.ff621e370ca7ap-1),  # 16
    (0x1.53e1f8p-35, 0x1.ab101bf74ac2ep-5, 0x1.ff4dc54b00181p-1),  # 17
    (0x1.114a649p-29, 0x1.c428d7de920e9p-5, 0x1.ff3830f2e9043p-1),  # 18
    (0x1.adf0ef4p-31, 0x1.dd40723a3cdfbp-5, 0x1.ff21614b9d9adp-1),  # 19
    (-0x1.d21f5918p-30, 0x1.f656e1e9e59cdp-5, 0x1.ff09565e83d77p-1),  # 20
    (-0x1.4f54d708p-30, 0x1.07b612d6be078p-4, 0x1.fef0102c634e3p-1),  # 21
    (-0x1.1efec9ap-30, 0x1.1440118ba7bdp-4, 0x1.fed58ecf342dap-1),  # 22
    (0x1.cc17ba88p-29, 0x1.20c96cf0a7eedp-4, 0x1.feb9d24646fa6p-1),  # 23
    (0x1.121dbe4p-33, 0x1.2d5209628edfp-4, 0x1.fe9cdacf99cffp-1),  # 24
    (-0x1.9ecf61p-34, 0x1.39d9f103bf7f7p-4, 0x1.fe7ea854e6b08p-1),  # 25
    (-0x1.04ede8ep-31, 0x1.466116c629e5cp-4, 0x1.fe5f3af4ee201p-1),  # 26
    (-0x1.1821cecp-31, 0x1.52e773c9920c7p-4, 0x1.fe3e92c0e4108p-1),  # 27
    (0x1.cdec726p-31, 0x1.5f6d02131f0b2p-4, 0x1.fe1cafc7f1a24p-1),  # 28
    (-0x1.edece4dp-31, 0x1.6bf1b2653648cp-4, 0x1.fdf99233c230cp-1),  # 29
    (-0x1.2aa4d1cp-31, 0x1.787585bc45f0fp-4, 0x1.fdd53a01d11d9p-1),  # 30
    (0x1.d461592p-32, 0x1.84f871e32cf68p-4, 0x1.fdafa74f16482p-1),  # 31
    (0x1.f0cbd728p-29, 0x1.917a71d3d2956p-4, 0x1.fd88da29f302ep-1),  # 32
    (-0x1.583247p-30, 0x1.9dfb6c9865b06p-4, 0x1.fd60d2e14a6b1p-1),  # 33
    (-0x1.2e81bf4p-30, 0x1.aa7b706bfdbbap-4, 0x1.fd3791484ff5p-1),  # 34
    (-0x1.13941418p-28, 0x1.b6fa680a05c27p-4, 0x1.fd0d15a4b8471p-1),  # 35
    (0x1.71098ffp-30, 0x1.c3785eba12b42p-4, 0x1.fce15fceddccfp-1),  # 36
    (-0x1.c3519e8p-32, 0x1.cff53302f059p-4, 0x1.fcb4703b969e1p-1),  # 37
    (0x1.2f522a5p-27, 0x1.dc70fb84af16ep-4, 0x1.fc8646987fc1dp-1),  # 38
    (-0x1.ae9bed8p-33, 0x1.e8eb7f8a589e2p-4, 0x1.fc56e3b91ca3ap-1),  # 39
    (0x1.f8868b2p-30, 0x1.f564e87d2330fp-4, 0x1.fc264701f9a09p-1),  # 40
    (-0x1.b07985f8p-29, 0x1.00ee8835051f4p-3, 0x1.fbf47105f7439p-1),  # 41
    (0x1.cbdaa94p-30, 0x1.072a05e1d4d8ep-3, 0x1.fbc16172a9e36p-1),  # 42
    (0x1.37c5b908p-28, 0x1.0d64df9619f0dp-3, 0x1.fb8d18b635327p-1),  # 43
    (-0x1.068b5fc8p-28, 0x1.139f09bc617f5p-3, 0x1.fb5797351da85p-1),  # 44
    (-0x1.8ea66818p-29, 0x1.19d8919fa4ec8p-3, 0x1.fb20dc7da8affp-1),  # 45
    (0x1.6278ceb8p-28, 0x1.2011719d50b87p-3, 0x1.fae8e8bd4427fp-1),  # 46
    (-0x1.096df84p-29, 0x1.264993433763ap-3, 0x1.faafbcbfca356p-1),  # 47
    (0x1.9b2534fp-29, 0x1.2c810967bbf7p-3, 0x1.fa7557d8d987ep-1),  # 48
    (0x1.215b4ep-34, 0x1.32b7bfa25c91bp-3, 0x1.fa39bac71954bp-1),  # 49
    (-0x1.94db891p-30, 0x1.38edb9d29b39dp-3, 0x1.f9fce56700a6dp-1),  # 50
    (0x1.7727f7b8p-29, 0x1.3f22f7c3cce3ap-3, 0x1.f9bed7b8c8d8cp-1),  # 51
    (-0x1.0cb33038p-29, 0x1.45576971dd53p-3, 0x1.f97f925d53c83p-1),  # 52
    (-0x1.9071106p-31, 0x1.4b8b175c71e22p-3, 0x1.f93f14feb8022p-1),  # 53
    (0x1.62741e78p-29, 0x1.51bdfa7ea30d5p-3, 0x1.f8fd5fe3efac8p-1),  # 54
    (0x1.f8e16d0cp-28, 0x1.57f00e80e6e12p-3, 0x1.f8ba733a1ceb1p-1),  # 55
    (-0x1.76acbcap-31, 0x1.5e2143b7bc1c2p-3, 0x1.f8764fad5e9bfp-1),  # 56
    (-0x1.0a0f73ap-30, 0x1.6451a76411746p-3, 0x1.f830f4ad232d8p-1),  # 57
    (0x1.ca11d1bcp-28, 0x1.6a8135d7bd143p-3, 0x1.f7ea625eb5af7p-1),  # 58
    (-0x1.02f23628p-29, 0x1.70afd74071191p-3, 0x1.f7a299d3f182ap-1),  # 59
    (0x1.b34dcb8p-29, 0x1.76dda08544b5cp-3, 0x1.f7599a1ac7ecdp-1),  # 60
    (0x1.161ff4p-32, 0x1.7d0a7bf2d4abap-3, 0x1.f70f64322da74p-1),  # 61
    (-0x1.c49b8b4p-31, 0x1.83366ddb3de23p-3, 0x1.f6c3f7e7c2707p-1),  # 62
    (0x1.21da851p-29, 0x1.8961743b1429p-3, 0x1.f6775552a6ba2p-1),  # 63
    (0x1.ac63edap-30, 0x1.8f8b851098588p-3, 0x1.f6297cef0cdd6p-1),  # 64
    (0x1.27ef489cp-27, 0x1.95b4a5b9f2cebp-3, 0x1.f5da6e7820551p-1),  # 65
    (0x1.ae8937p-30, 0x1.9bdcc07900146p-3, 0x1.f58a2b0689c82p-1),  # 66
    (0x1.eb48c7ep-29, 0x1.a203e4a4f950ep-3, 0x1.f538b1d392049p-1),  # 67
    (-0x1.bfd282fp-29, 0x1.a829ffaad0d79p-3, 0x1.f4e603d51f1aap-1),  # 68
    (0x1.7ccf638p-29, 0x1.ae4f1fa80e1b5p-3, 0x1.f492204c5ef9ep-1),  # 69
    (-0x1.2435c578p-28, 0x1.b4732b72ebc86p-3, 0x1.f43d0890e1e72p-1),  # 70
    (0x1.0293fecp-30, 0x1.ba9634155f866p-3, 0x1.f3e6bbb6c2ea4p-1),  # 71
    (-0x1.7bb1f92p-29, 0x1.c0b82461f65ep-3, 0x1.f38f3ae6f9afcp-1),  # 72
    (0x1.27aaebcp-29, 0x1.c6d906faacf65p-3, 0x1.f3368589e17a2p-1),  # 73
    (-0x1.2e2bcd5p-27, 0x1.ccf8c3f74a6c9p-3, 0x1.f2dc9cfb5fa74p-1),  # 74
    (-0x1.6f070acp-30, 0x1.d31773ba218a8p-3, 0x1.f2817fd4d045bp-1),  # 75
    (0x1.469adfcp-29, 0x1.d935004779e57p-3, 0x1.f2252f59c122dp-1),  # 76
    (0x1.4f51c18p-32, 0x1.df5164301377ap-3, 0x1.f1c7abdeaa3efp-1),  # 77
    (0x1.78e44dap-29, 0x1.e56ca4202807cp-3, 0x1.f168f51c5d5d5p-1),  # 78
    (0x1.49bb5f8p-32, 0x1.eb86b4a1b7e9bp-3, 0x1.f1090bc4b68p-1),  # 79
    (-0x1.67ba541p-28, 0x1.f19f9369d5e93p-3, 0x1.f0a7effdc937fp-1),  # 80
    (0x1.c0cab95p-29, 0x1.f7b74ab7219d2p-3, 0x1.f045a1219e594p-1),  # 81
    (-0x1.2b77e32p-30, 0x1.fdcdc0ca3288dp-3, 0x1.efe220cf5c751p-1),  # 82
    (-0x1.e0d8cbp-33, 0x1.01f18054c8362p-2, 0x1.ef7d6e54c347dp-1),  # 83
    (-0x1.ecd5b9cp-29, 0x1.04fb7f6d35d68p-2, 0x1.ef178a6f9a987p-1),  # 84
    (0x1.eb24de5p-29, 0x1.0804e1d369ff2p-2, 0x1.eeb074934fdfp-1),  # 85
    (0x1.4a897c4p-30, 0x1.0b0d9d7b0d042p-2, 0x1.ee482e14bcdep-1),  # 86
    (0x1.336c376p-30, 0x1.0e15b555e7becp-2, 0x1.eddeb6908ca8cp-1),  # 87
    (-0x1.3952d9p-31, 0x1.111d25efd48b8p-2, 0x1.ed740e7eb8dd6p-1),  # 88
    (0x1.fc2a5d4p-31, 0x1.1423ef5c7e1bdp-2, 0x1.ed0835dc24e89p-1),  # 89
    (0x1.a88ed37p-29, 0x1.172a0eb8361dap-2, 0x1.ec9b2d0ec8288p-1),  # 90
    (-0x1.8ca4cb94p-27, 0x1.1a2f7b10b6d7p-2, 0x1.ec2cf55d6117cp-1),  # 91
    (0x1.0144524p-27, 0x1.1d3446fd0cd3fp-2, 0x1.ebbd8c1d62f96p-1),  # 92
    (-0x1.abf810cp-28, 0x1.203855b85f89ap-2, 0x1.eb4cf57454132p-1),  # 93
    (0x1.5d4c5d58p-28, 0x1.233bbcca40561p-2, 0x1.eadb2e40746cap-1),  # 94
    (-0x1.a1b0c58p-29, 0x1.263e685b1d714p-2, 0x1.ea68396d87754p-1),  # 95
    (-0x1.77c8dacp-29, 0x1.294061d2eb611p-2, 0x1.e9f41597393c8p-1),  # 96
    (0x1.915540ep-30, 0x1.2c41a580014cfp-2, 0x1.e97ec348fb87fp-1),  # 97
    (-0x1.abb6d9bp-28, 0x1.2f422b2d0990cp-2, 0x1.e90843c55b996p-1),  # 98
    (-0x1.b8ee5d58p-28, 0x1.3241f8cea2836p-2, 0x1.e890962268c49p-1),  # 99
    (-0x1.1cd29828p-28, 0x1.35410a8396266p-2, 0x1.e817baf85c094p-1),  # 100
    (-0x1.e216afp-32, 0x1.383f5e08283e2p-2, 0x1.e79db2a188b0ap-1),  # 101
    (-0x1.24afc3p-31, 0x1.3b3cef6993c0bp-2, 0x1.e7227dbf82004p-1),  # 102
    (-0x1.aa1657cp-31, 0x1.3e39be4767224p-2, 0x1.e6a61c62d5274p-1),  # 103
    (-0x1.c5b65fap-30, 0x1.4135c898485bbp-2, 0x1.e6288ee07fea5p-1),  # 104
    (0x1.23e8978p-32, 0x1.44310de3c284bp-2, 0x1.e5a9d54bbd26cp-1),  # 105
    (-0x1.2b1d77ap-29, 0x1.472b8976d498dp-2, 0x1.e529f06cb187dp-1),  # 106
    (-0x1.daaa348p-31, 0x1.4a253cb97efd1p-2, 0x1.e4a8e007231a2p-1),  # 107
    (-0x1.322f5708p-28, 0x1.4d1e2260c3422p-2, 0x1.e426a500f6e33p-1),  # 108
    (0x1.64758e8p-29, 0x1.50163eca0b337p-2, 0x1.e3a33e996b722p-1),  # 109
    (0x1.12486278p-28, 0x1.530d89a17e007p-2, 0x1.e31eae3fb917bp-1),  # 110
    (-0x1.6c3416ccp-27, 0x1.5603fcf8cd8a3p-2, 0x1.e298f502a579bp-1),  # 111
    (0x1.ab481ffp-29, 0x1.58f9a896aa209p-2, 0x1.e2121016e14fcp-1),  # 112
    (-0x1.6eb838bp-29, 0x1.5bee77aaf890bp-2, 0x1.e18a032eb4df5p-1),  # 113
    (-0x1.d159b8p-32, 0x1.5ee2734efeef5p-2, 0x1.e100ccaa6bd78p-1),  # 114
    (-0x1.a42e4ap-34, 0x1.61d595bedeabcp-2, 0x1.e0766d944915ep-1),  # 115
    (-0x1.43d0dcp-30, 0x1.64c7dd5cc0cd1p-2, 0x1.dfeae63903034p-1),  # 116
    (-0x1.8c7bdb7p-27, 0x1.67b9453ca2122p-2, 0x1.df5e378482eaep-1),  # 117
    (0x1.1c0ead6p-30, 0x1.6aa9d844c980ap-2, 0x1.ded05f6a23a52p-1),  # 118
    (0x1.7d526p-31, 0x1.6d99867e90d92p-2, 0x1.de4160e97b2e2p-1),  # 119
    (0x1.924e0368p-28, 0x1.7088555d3c816p-2, 0x1.ddb13afb14e37p-1),  # 120
    (-0x1.74b7c3ep-30, 0x1.73763c09fba09p-2, 0x1.dd1fef5335416p-1),  # 121
    (-0x1.7943adp-30, 0x1.766340685c982p-2, 0x1.dc8d7ccf2567ap-1),  # 122
    (0x1.79dd614p-29, 0x1.794f5f7522b88p-2, 0x1.dbf9e402aa5c3p-1),  # 123
    (0x1.7b64f32p-30, 0x1.7c3a939c32d81p-2, 0x1.db652607e0db1p-1),  # 124
    (-0x1.2bea5ce8p-28, 0x1.7f24db825141cp-2, 0x1.dacf43268b5bp-1),  # 125
    (0x1.733c024p-30, 0x1.820e3b8bf15ap-2, 0x1.da383a7aed887p-1),  # 126
    (-0x1.eac0fc94p-27, 0x1.84f6a51d077b3p-2, 0x1.d9a00efd84537p-1),  # 127
    (0x1.aca37338p-27, 0x1.87de2f4704f98p-2, 0x1.d906bbf17f4dap-1),  # 128
    (-0x1.910c4fp-30, 0x1.8ac4b7dc0d986p-2, 0x1.d86c4862b5d6ep-1),  # 129
    (-0x1.33bb86p-31, 0x1.8daa52b4dc041p-2, 0x1.d7d0b0374a559p-1),  # 130
    (-0x1.69e1507p-27, 0x1.908ef408ad22p-2, 0x1.d733f5e71c3bcp-1),  # 131
    (0x1.cffacf08p-27, 0x1.9372ab7784d36p-2, 0x1.d696161d786c9p-1),  # 132
    (-0x1.8629d9fp-26, 0x1.965552b0849abp-2, 0x1.d5f7190eeae23p-1),  # 133
    (0x1.415p-30, 0x1.99371687c64f3p-2, 0x1.d556f5155d9ddp-1),  # 134
    (-0x1.bd37aad8p-27, 0x1.9c17cf40715cbp-2, 0x1.d4b5b2caf8386p-1),  # 135
    (0x1.d02cde7p-26, 0x1.9ef79ea4d995dp-2, 0x1.d4134ac5eb246p-1),  # 136
    (-0x1.10547acp-30, 0x1.a1d653d9adf5ep-2, 0x1.d36fc7d291602p-1),  # 137
    (-0x1.01a1a228p-27, 0x1.a4b40f9c0120bp-2, 0x1.d2cb22b45236bp-1),  # 138
    (0x1.3ce2bacp-29, 0x1.a790ce2056b9ap-2, 0x1.d2255c3ae11a5p-1),  # 139
    (-0x1.ccb4a6p-32, 0x1.aa6c828db4ea8p-2, 0x1.d17e774d4e3e2p-1),  # 140
    (0x1.5db4bp-29, 0x1.ad47321f29847p-2, 0x1.d0d672bc0b122p-1),  # 141
    (0x1.32f6a6ep-29, 0x1.b020d7a285e23p-2, 0x1.d02d4fb84d334p-1),  # 142
    (0x1.cf8e39bcp-26, 0x1.b2f97c27f7494p-2, 0x1.cf830c2248c5ep-1),  # 143
    (0x1.8927bbp-30, 0x1.b5d10129a750ap-2, 0x1.ced7af22cb105p-1),  # 144
    (-0x1.3dec3c1p-28, 0x1.b8a77f8d0bbc5p-2, 0x1.ce2b32e50d6cdp-1),  # 145
    (-0x1.26ba536p-28, 0x1.bb7cf08f0290dp-2, 0x1.cd7d98fcf3b1ep-1),  # 146
    (0x1.23c568ep-29, 0x1.be51524e3aa53p-2, 0x1.cccee1da3d56ep-1),  # 147
    (-0x1.f3b3afp-29, 0x1.c1249c1f5f2f6p-2, 0x1.cc1f0f95e1e24p-1),  # 148
    (-0x1.1286a47p-28, 0x1.c3f6d2ef7054bp-2, 0x1.cb6e20ff37e81p-1),  # 149
    (0x1.641214ep-29, 0x1.c6c7f594003d9p-2, 0x1.cabc165bf1b6p-1),  # 150
    (0x1.0cda7c9p-27, 0x1.c997ff2bffccbp-2, 0x1.ca08f0dee434cp-1),  # 151
    (-0x1.5557ac9p-28, 0x1.cc66e7b42e8f1p-2, 0x1.c954b28bca62ep-1),  # 152
    (0x1.555eb62p-28, 0x1.cf34bccc567a1p-2, 0x1.c89f57f6e20f3p-1),  # 153
    (-0x1.4e0e361p-28, 0x1.d2016cbb5e39ap-2, 0x1.c7e8e59999e1fp-1),  # 154
    (0x1.446da1ep-29, 0x1.d4cd039d0ed05p-2, 0x1.c731585f970ebp-1),  # 155
    (0x1.103d328p-29, 0x1.d797767638decp-2, 0x1.c678b3174afe1p-1),  # 156
    (0x1.5814d6p-28, 0x1.da60c7ae9dc22p-2, 0x1.c5bef522be6fbp-1),  # 157
    (-0x1.5e2321ep-29, 0x1.dd28f054cbb3fp-2, 0x1.c5042052c8c42p-1),  # 158
    (-0x1.a259ffep-29, 0x1.dfeff54854631p-2, 0x1.c44833611bc7dp-1),  # 159
    (-0x1.4f28d8p-31, 0x1.e2b5d34665b35p-2, 0x1.c38b2f278ea7ep-1),  # 160
    (-0x1.de571p-36, 0x1.e57a86d137f2p-2, 0x1.c2cd1493d05c2p-1),  # 161
    (0x1.e0d8d14p-29, 0x1.e83e0ffb7bfb4p-2, 0x1.c20de3a08ea07p-1),  # 162
    (-0x1.12a858ep-28, 0x1.eb0067e48baf4p-2, 0x1.c14d9e2bd511ep-1),  # 163
    (0x1.9a17403p-27, 0x1.edc19997a4431p-2, 0x1.c08c413089b2ep-1),  # 164
    (0x1.68c8636p-29, 0x1.f0819163d1bcp-2, 0x1.bfc9d21568f32p-1),  # 165
    (0x1.4cc5eb8p-29, 0x1.f3405a482e11dp-2, 0x1.bf064dd580fc9p-1),  # 166
    (-0x1.fce7cd8p-27, 0x1.f5fde8f3f11d4p-2, 0x1.be41b798f6b97p-1),  # 167
    (-0x1.af8169p-29, 0x1.f8ba4c98a9816p-2, 0x1.bd7c0b1a7f14bp-1),  # 168
    (0x1.6e39e2p-33, 0x1.fb7575d1ea75p-2, 0x1.bcb54cac5dde5p-1),  # 169
    (0x1.30f9256p-28, 0x1.fe2f665dcd168p-2, 0x1.bbed7bd1e17bp-1),  # 170
    (0x1.626de2p-31, 0x1.00740ca0d5fbbp-1, 0x1.bb2499f9fe7a3p-1),  # 171
    (0x1.5cc703p-30, 0x1.01cfc8afeea0ep-1, 0x1.ba5aa650dd495p-1),  # 172
    (-0x1.6191e6p-32, 0x1.032ae54fe4057p-1, 0x1.b98fa2065a5e6p-1),  # 173
    (-0x1.6b1485p-31, 0x1.0485624c328c8p-1, 0x1.b8c38d39737bcp-1),  # 174
    (-0x1.11fbc3ap-29, 0x1.05df3e66a716dp-1, 0x1.b7f668a580fdp-1),  # 175
    (-0x1.0eca7fp-27, 0x1.07387825589ecp-1, 0x1.b728352c44517p-1),  # 176
    (-0x1.8073bc9ep-25, 0x1.089109ef1284dp-1, 0x1.b658f630112edp-1),  # 177
    (-0x1.9dcf0adp-27, 0x1.09e9051603e29p-1, 0x1.b588a13ab750fp-1),  # 178
    (-0x1.06ea9fp-29, 0x1.0b405820e78e7p-1, 0x1.b4b740d3cc07bp-1),  # 179
    (-0x1.36a8d0cp-30, 0x1.0c9704a1ea4e5p-1, 0x1.b3e4d40f5524dp-1),  # 180
    (0x1.63d1f3p-30, 0x1.0ded0bc01a533p-1, 0x1.b3115a3a628afp-1),  # 181
    (0x1.f3181f14p-26, 0x1.0f4270e4787bfp-1, 0x1.b23cd1314c779p-1),  # 182
    (-0x1.f269b78p-29, 0x1.109723e75c5cfp-1, 0x1.b167430cfebdbp-1),  # 183
    (0x1.1d84dc08p-27, 0x1.11eb36bc9db52p-1, 0x1.b090a4915ee88p-1),  # 184
    (-0x1.08e60068p-27, 0x1.133e9ba0061d8p-1, 0x1.afb8fe69a6527p-1),  # 185
    (0x1.cda72abp-27, 0x1.14915d557a7c9p-1, 0x1.aee049bc0aeep-1),  # 186
    (-0x1.f32f95p-30, 0x1.15e36dfb6bb55p-1, 0x1.ae068f6991699p-1),  # 187
    (0x1.138092dp-28, 0x1.1734d6f34d7fp-1, 0x1.ad2bc96c1e1f5p-1),  # 188
    (0x1.6b382dd4p-26, 0x1.188595ae376a5p-1, 0x1.ac4ff962bdb6dp-1),  # 189
    (-0x1.f12fafap-28, 0x1.19d59f592a587p-1, 0x1.ab7326685eb57p-1),  # 190
    (-0x1.2909e5ap-28, 0x1.1b2500aed7ac6p-1, 0x1.aa954823cf815p-1),  # 191
    (-0x1.d66a8978p-25, 0x1.1c73aa0150cf9p-1, 0x1.a9b668fb0503fp-1),  # 192
    (0x1.311ea86p-27, 0x1.1dc1b7db74db1p-1, 0x1.a8d675d9c6cc8p-1),  # 193
    (-0x1.41c02b8p-31, 0x1.1f0f08a1a06a4p-1, 0x1.a7f5853bb4309p-1),  # 194
    (-0x1.ca1f4edp-26, 0x1.205ba57211271p-1, 0x1.a71391146958fp-1),  # 195
    (-0x1.910ce77p-28, 0x1.21a7988f8326bp-1, 0x1.a63092626202fp-1),  # 196
    (0x1.2bfadbeep-25, 0x1.22f2dc71afab6p-1, 0x1.a54c8cd9fd0d9p-1),  # 197
    (-0x1.5f1c02a8p-27, 0x1.243d5df4afb93p-1, 0x1.a4678dbbe5e73p-1),  # 198
    (-0x1.db12b9p-30, 0x1.2587347f493a4p-1, 0x1.a38184db0df23p-1),  # 199
    (-0x1.7b29ep-30, 0x1.26d05490f2f61p-1, 0x1.a29a7a2f40b49p-1),  # 200
    (-0x1.b3ddca4p-29, 0x1.2818be6930629p-1, 0x1.a1b26d8f070d7p-1),  # 201
    (0x1.e112744p-29, 0x1.2960730ff2bcdp-1, 0x1.a0c95e3df5e0ep-1),  # 202
    (-0x1.5269766p-28, 0x1.2aa76dafcbbf4p-1, 0x1.9fdf4fae1df6fp-1),  # 203
    (-0x1.09777e1p-28, 0x1.2bedb1b6b4e15p-1, 0x1.9ef43f6cbe162p-1),  # 204
    (0x1.ae2051fp-28, 0x1.2d333e4617f25p-1, 0x1.9e082e148680ep-1),  # 205
    (-0x1.36f6ced8p-27, 0x1.2e780cb47180ep-1, 0x1.9d1b207f383c3p-1),  # 206
    (-0x1.23fdc6bp-28, 0x1.2fbc23fba2f44p-1, 0x1.9c2d1197130a7p-1),  # 207
    (0x1.bc540ep-33, 0x1.30ff7fd6d967dp-1, 0x1.9b3e0478b961bp-1),  # 208
    (-0x1.cfb4ed7p-28, 0x1.32421da0bf0e9p-1, 0x1.9a4dfb1c89326p-1),  # 209
    (0x1.55802aecp-26, 0x1.3384042a92b1dp-1, 0x1.995cf06920d11p-1),  # 210
    (0x1.60719e4p-28, 0x1.34c52608e3a92p-1, 0x1.986aee6d6837ep-1),  # 211
    (-0x1.cbf2e48p-30, 0x1.36058ac8863b6p-1, 0x1.9777ef832c986p-1),  # 212
    (0x1.9061c32p-27, 0x1.374533ab707dp-1, 0x1.9683f2ad7e2ecp-1),  # 213
    (-0x1.da84dfep-27, 0x1.3884160f9488fp-1, 0x1.958f000fdd50ap-1),  # 214
    (0x1.92e8a74p-29, 0x1.39c23eba6b22ap-1, 0x1.94990dd9cee51p-1),  # 215
    (-0x1.bff5d9ap-29, 0x1.3affa20756bddp-1, 0x1.93a225056084ap-1),  # 216
    (0x1.4c462p-36, 0x1.3c3c4498e98ebp-1, 0x1.92aa41fbb951cp-1),  # 217
    (-0x1.e4613e9p-28, 0x1.3d782261dff62p-1, 0x1.91b167e92d706p-1),  # 218
    (0x1.0eb2964p-30, 0x1.3eb33ed579bbep-1, 0x1.90b794146043cp-1),  # 219
    (-0x1.60abec2p-29, 0x1.3fed94c834d8ap-1, 0x1.8fbcca9583479p-1),  # 220
    (0x1.6954977p-27, 0x1.4127281ddac03p-1, 0x1.8ec1085083553p-1),  # 221
    (0x1.a16fec2p-29, 0x1.425ff1f841235p-1, 0x1.8dc452ca328d3p-1),  # 222
    (-0x1.27bcdd3p-27, 0x1.4397f44aa44f2p-1, 0x1.8cc6a8771e165p-1),  # 223
    (-0x1.60dded4p-28, 0x1.44cf317a563dbp-1, 0x1.8bc8076122736p-1),  # 224
    (-0x1.9a8f405cp-26, 0x1.4605a2b02d705p-1, 0x1.8ac875232f3efp-1),  # 225
    (0x1.32777dcp-27, 0x1.473b532bc5a67p-1, 0x1.89c7e8713120cp-1),  # 226
    (-0x1.1418a7bp-26, 0x1.4870306ca20e2p-1, 0x1.88c670a0ea774p-1),  # 227
    (-0x1.fed182ep-28, 0x1.49a44886b534p-1, 0x1.87c401fdf05e5p-1),  # 228
    (0x1.86144d8p-27, 0x1.4ad796ea1410cp-1, 0x1.86c0a04dbacc5p-1),  # 229
    (0x1.1bc2e6p-33, 0x1.4c0a14640d2afp-1, 0x1.85bc51aa114c2p-1),  # 230
    (-0x1.f53d2fep-28, 0x1.4d3bc5aaa8cd5p-1, 0x1.84b7121b30a13p-1),  # 231
    (-0x1.2e100ap-30, 0x1.4e6cab91556bep-1, 0x1.83b0e0e6b6cccp-1),  # 232
    (-0x1.fa58c62p-29, 0x1.4f9cc1c69fddep-1, 0x1.82a9c1c1ab463p-1),  # 233
    (0x1.bb491ep-33, 0x1.50cc09fdcbd92p-1, 0x1.81a1b3342f858p-1),  # 234
    (0x1.a11541p-28, 0x1.51fa82c3aa029p-1, 0x1.8098b67ea8509p-1),  # 235
    (0x1.ab0a5d3p-27, 0x1.53282b20b96b6p-1, 0x1.7f8ecc791953p-1),  # 236
    (-0x1.cba0438p-28, 0x1.5454fe43a7d7cp-1, 0x1.7e83f96af78ap-1),  # 237
    (-0x1.0dd83a4p-29, 0x1.5581033a81573p-1, 0x1.7d783712e20ecp-1),  # 238
    (-0x1.e9a8299p-28, 0x1.56ac33fbb8253p-1, 0x1.7c6b8acf90fa6p-1),  # 239
    (0x1.225c4aap-29, 0x1.57d6939d4b513p-1, 0x1.7b5df1da18065p-1),  # 240
    (-0x1.82e66ep-27, 0x1.59001b9e64d79p-1, 0x1.7a4f72157cfdfp-1),  # 241
    (0x1.51a6a354p-26, 0x1.5a28d5b36d597p-1, 0x1.794002a7c9023p-1),  # 242
    (0x1.13917f4p-26, 0x1.5b50b4e10bec1p-1, 0x1.782faf6dc7ba2p-1),  # 243
    (0x1.49310ccp-30, 0x1.5c77bc15ab4efp-1, 0x1.771e75c43942ep-1),  # 244
    (0x1.24d493cp-30, 0x1.5d9dee9de49dbp-1, 0x1.760c529bc17bp-1),  # 245
    (-0x1.04638f7p-26, 0x1.5ec347044e0f4p-1, 0x1.74f94b0af972p-1),  # 246
    (-0x1.3f41b28p-29, 0x1.5fe7cb834600cp-1, 0x1.73e55936a516p-1),  # 247
    (-0x1.a5f6f5cp-30, 0x1.610b7515d1562p-1, 0x1.72d083b8214ebp-1),  # 248
    (0x1.19fb2ep-28, 0x1.622e459eafbc1p-1, 0x1.71bac8c7b0592p-1),  # 249
    (-0x1.56d2c2bp-28, 0x1.6350396fe4e62p-1, 0x1.70a42bec51665p-1),  # 250
    (-0x1.3c156c2p-28, 0x1.64715385bed93p-1, 0x1.6f8caa4969708p-1),  # 251
    (-0x1.f23e576p-29, 0x1.659191d2fd57fp-1, 0x1.6e7445d74f711p-1),  # 252
    (0x1.1e4be38p-30, 0x1.66b0f41d484c4p-1, 0x1.6d5afecd4938dp-1),  # 253
    (-0x1.397cc8d8p-27, 0x1.67cf76eac73dfp-1, 0x1.6c40d89625f63p-1),  # 254
    (-0x1.202f686p-28, 0x1.68ed1e0990551p-1, 0x1.6b25cf728c35p-1),  # 255
]

# Hard-to-round exceptions for sin_accurate
const SIN_EXCEPTIONS = (
    (0x1.e0000000001c2p-20, 0x1.dfffffffff02ep-20, 0x1.dcba692492527p-146),
    (0x1.6ac5b262ca1ffp+849, 1.0, -0x1.2b089ea1e692bp-123),
)
