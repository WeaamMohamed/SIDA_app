import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './SecondSplash.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstSplash extends StatelessWidget {
  FirstSplash({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(start: 0.0, end: 0.0),
            child:
                // Adobe XD layer: 'splash_bg_cairo' (shape)
                PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.linear,
                  duration: 1.0,
                  pageBuilder: () => SecondSplash(),
                ),
              ],
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        const AssetImage('assets/images/splash_bg_cairo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 204.1, middle: 0.4973),
            Pin(size: 55.3, middle: 0.4995),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.linear,
                  duration: 1.0,
                  pageBuilder: () => SecondSplash(),
                ),
              ],
              child: Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(size: 52.3, start: 0.0),
                    Pin(start: 0.9, end: 0.0),
                    child: SvgPicture.string(
                      _svg_w94cr,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 12.8, middle: 0.3259),
                    Pin(start: 0.9, end: 0.9),
                    child: SvgPicture.string(
                      _svg_ij6lzw,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 51.7, middle: 0.5542),
                    Pin(start: 1.0, end: 0.8),
                    child: SvgPicture.string(
                      _svg_ozo7qu,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 64.0, end: 0.0),
                    Pin(start: 0.0, end: 0.8),
                    child: SvgPicture.string(
                      _svg_td1l40,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 15.2, end: 24.4),
                    Pin(size: 12.5, end: 0.9),
                    child: SvgPicture.string(
                      _svg_bg9wmd,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 3.2, middle: 0.5359),
                    Pin(size: 5.2, middle: 0.5002),
                    child: SvgPicture.string(
                      _svg_srgkw2,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 14.2, middle: 0.539),
                    Pin(size: 8.2, middle: 0.4594),
                    child: SvgPicture.string(
                      _svg_jt1z5,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 14.2, middle: 0.5373),
                    Pin(size: 8.2, middle: 0.5407),
                    child: SvgPicture.string(
                      _svg_xd49wn,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_w94cr =
    '<svg viewBox="85.0 378.9 52.3 54.4" ><path transform="translate(-2511.59, 877.97)" d="M 2647.75390625 -466.1592102050781 C 2648.206298828125 -464.6035461425781 2648.433349609375 -462.9693603515625 2648.433349609375 -461.3362426757812 C 2648.433349609375 -459.7026672363281 2648.206298828125 -458.0686950683594 2647.75390625 -456.5128479003906 C 2646.7744140625 -453.1675109863281 2644.740966796875 -450.1339416503906 2642.02685546875 -448.0331115722656 C 2639.23876953125 -445.8550720214844 2635.847900390625 -444.6883544921875 2632.30615234375 -444.6883544921875 L 2596.662353515625 -444.6883544921875 L 2596.662353515625 -457.9135131835938 L 2632.30615234375 -457.9135131835938 C 2634.11474609375 -457.9135131835938 2635.622802734375 -459.4688110351562 2635.622802734375 -461.3362426757812 C 2635.622802734375 -463.2033081054688 2634.11474609375 -464.758544921875 2632.30615234375 -464.758544921875 L 2612.788330078125 -464.758544921875 C 2611.20947265625 -464.758544921875 2609.62548828125 -464.9924621582031 2608.118896484375 -465.4592590332031 C 2605.557861328125 -466.2372741699219 2603.220947265625 -467.7153015136719 2601.33740234375 -469.6600646972656 C 2599.452392578125 -471.6042175292969 2598.021484375 -474.0166015625 2597.26513671875 -476.6613464355469 C 2596.81494140625 -478.2174377441406 2596.58984375 -479.8509826660156 2596.58984375 -481.4848022460938 C 2596.58984375 -483.118408203125 2596.81494140625 -484.7516479492188 2597.26513671875 -486.3079223632812 C 2598.021484375 -488.9533996582031 2599.452392578125 -491.3646850585938 2601.33740234375 -493.3086853027344 C 2603.220947265625 -495.2538452148438 2605.557861328125 -496.732177734375 2608.118896484375 -497.5098876953125 C 2608.496826171875 -497.6655883789062 2608.87060546875 -497.7438354492188 2609.248291015625 -497.8208618164062 L 2609.77587890625 -497.9774169921875 L 2622.361328125 -484.9856567382812 L 2612.788330078125 -484.9856567382812 C 2610.983642578125 -484.9856567382812 2609.4755859375 -483.4293823242188 2609.4755859375 -481.5621643066406 C 2609.4755859375 -479.6953430175781 2610.983642578125 -478.1393737792969 2612.788330078125 -478.1393737792969 L 2632.30615234375 -478.1393737792969 L 2632.534423828125 -478.1393737792969 L 2632.6083984375 -478.1393737792969 L 2632.83349609375 -478.1393737792969 L 2632.984619140625 -478.1393737792969 L 2633.436767578125 -478.1393737792969 L 2633.661865234375 -478.1393737792969 L 2633.7392578125 -478.1393737792969 L 2633.9638671875 -478.1393737792969 L 2634.417236328125 -478.1393737792969 L 2634.64111328125 -478.1393737792969 L 2634.7197265625 -478.1393737792969 L 2635.169189453125 -478.1393737792969 L 2635.395751953125 -478.1393737792969 L 2635.847900390625 -478.1393737792969 L 2635.924072265625 -478.1393737792969 C 2636.07177734375 -478.1393737792969 2636.22412109375 -478.0616760253906 2636.37548828125 -477.9836120605469 L 2636.449951171875 -477.9836120605469 L 2636.601318359375 -477.90576171875 L 2636.826904296875 -477.90576171875 C 2636.977294921875 -477.8285827636719 2637.12890625 -477.7503967285156 2637.27978515625 -477.6728210449219 L 2637.3544921875 -477.6728210449219 C 2637.65625 -477.5947570800781 2637.9580078125 -477.5171203613281 2638.26123046875 -477.4390258789062 L 2638.335693359375 -477.4390258789062 C 2638.484619140625 -477.3617248535156 2638.63671875 -477.2839660644531 2638.787109375 -477.2059631347656 L 2638.86181640625 -477.2059631347656 C 2639.089111328125 -477.1280822753906 2639.314697265625 -477.0499877929688 2639.541259765625 -476.9725036621094 L 2639.766845703125 -476.9725036621094 C 2639.916748046875 -476.8948059082031 2640.067138671875 -476.8169250488281 2640.217529296875 -476.7397766113281 C 2640.443603515625 -476.58349609375 2640.671630859375 -476.4282531738281 2640.896484375 -476.2723388671875 L 2641.272705078125 -476.0392150878906 C 2641.424072265625 -475.9613952636719 2641.574951171875 -475.88330078125 2641.724853515625 -475.8058166503906 C 2641.876953125 -475.7277221679688 2642.02685546875 -475.6498413085938 2642.17724609375 -475.5726623535156 L 2642.254150390625 -475.4946594238281 C 2642.554931640625 -475.260986328125 2642.8544921875 -475.0281066894531 2643.156982421875 -474.7943115234375 C 2643.231689453125 -474.7164306640625 2643.383544921875 -474.6392517089844 2643.532958984375 -474.483154296875 C 2643.608642578125 -474.4056396484375 2643.68798828125 -474.3277587890625 2643.758056640625 -474.2496948242188 L 2643.910888671875 -474.0946350097656 C 2643.9853515625 -474.0946350097656 2644.0634765625 -474.0946350097656 2644.13525390625 -474.0166015625 C 2644.212646484375 -473.9381713867188 2644.28662109375 -473.8604736328125 2644.365234375 -473.7833251953125 C 2644.591064453125 -473.549560546875 2644.815185546875 -473.31640625 2645.041259765625 -473.0830078125 L 2645.266357421875 -472.849853515625 L 2645.41748046875 -472.6939697265625 L 2645.41748046875 -472.4603881835938 L 2645.64306640625 -472.2272338867188 L 2645.719970703125 -472.1494140625 C 2645.79296875 -471.9934387207031 2645.870361328125 -471.8380737304688 2645.945068359375 -471.6824951171875 C 2646.020263671875 -471.6042175292969 2646.095458984375 -471.5274658203125 2646.170654296875 -471.44921875 C 2646.246826171875 -471.3711242675781 2646.322021484375 -471.2936401367188 2646.397216796875 -471.2157592773438 L 2646.473876953125 -471.060546875 L 2647.150390625 -469.6600646972656 L 2647.227294921875 -469.5823059082031 C 2647.377197265625 -469.2706604003906 2647.528076171875 -468.9595031738281 2647.67724609375 -468.6488952636719 L 2647.75390625 -468.4929504394531 L 2647.979736328125 -467.7931823730469 L 2647.979736328125 -467.5595397949219 L 2648.206298828125 -467.0145263671875 L 2647.75390625 -466.1592102050781 Z M 2648.88330078125 -499.0661010742188 L 2648.88330078125 -485.8408813476562 L 2628.688720703125 -485.8408813476562 L 2615.882568359375 -499.0661010742188 L 2648.88330078125 -499.0661010742188 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ij6lzw =
    '<svg viewBox="147.3 378.9 12.8 53.5" ><path transform="translate(-2542.8, 877.97)" d="M 2702.957275390625 -499.0661010742188 L 2702.957275390625 -479.2173461914062 L 2690.14453125 -492.4496765136719 L 2690.14453125 -499.0661010742188 L 2702.957275390625 -499.0661010742188 Z M 2690.14453125 -486.3785095214844 L 2702.957275390625 -473.1466979980469 L 2702.957275390625 -445.5924987792969 L 2690.14453125 -445.5924987792969 L 2690.14453125 -486.3785095214844 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_ozo7qu =
    '<svg viewBox="169.5 379.0 51.7 53.5" ><path transform="translate(-2552.5, 877.93)" d="M 2769.126708984375 -487.2733154296875 C 2772.065185546875 -482.8359069824219 2773.650634765625 -477.6214904785156 2773.650634765625 -472.1726379394531 C 2773.650634765625 -466.8018188476562 2772.065185546875 -461.5866394042969 2769.126708984375 -457.1499633789062 C 2769.052978515625 -457.0722351074219 2768.976806640625 -456.9943237304688 2768.901123046875 -456.9169311523438 C 2764.07666015625 -449.7555236816406 2756.166259765625 -445.4752807617188 2747.72998046875 -445.4752807617188 L 2721.958984375 -445.4752807617188 L 2721.958984375 -477.7774658203125 L 2734.8447265625 -464.4667663574219 L 2734.8447265625 -458.7846069335938 L 2747.72998046875 -458.7846069335938 L 2748.634521484375 -458.7846069335938 C 2752.550537109375 -459.0184326171875 2756.090576171875 -461.1196899414062 2758.355224609375 -464.4667663574219 L 2758.355224609375 -464.5448913574219 C 2759.785888671875 -466.8018188476562 2760.536865234375 -469.4482421875 2760.536865234375 -472.1726379394531 C 2760.536865234375 -474.8969421386719 2759.785888671875 -477.5429077148438 2758.2763671875 -479.8006591796875 C 2755.865966796875 -483.3805541992188 2751.948486328125 -485.5603637695312 2747.72998046875 -485.5603637695312 L 2734.8447265625 -485.5603637695312 L 2734.8447265625 -470.4603881835938 L 2721.958984375 -483.7698059082031 L 2721.958984375 -498.9480590820312 L 2747.72998046875 -498.9480590820312 C 2756.166259765625 -498.9480590820312 2764.07666015625 -494.6667785644531 2768.901123046875 -487.5065307617188 L 2769.126708984375 -487.2733154296875 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_td1l40 =
    '<svg viewBox="225.1 378.0 64.0 54.5" ><path transform="translate(-2578.5, 878.48)" d="M 2825.767333984375 -483.6777954101562 L 2833.227783203125 -470.919921875 L 2818.610107421875 -446.1049499511719 L 2803.6142578125 -446.1049499511719 L 2825.767333984375 -483.6777954101562 Z M 2867.5869140625 -446.0270690917969 L 2852.59326171875 -446.0270690917969 L 2849.50341796875 -451.3164978027344 L 2828.177734375 -487.8003540039062 L 2835.637939453125 -500.4801330566406 L 2867.5869140625 -446.0270690917969 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_bg9wmd =
    '<svg viewBox="249.5 419.8 15.2 12.5" ><path transform="translate(-2592.27, 857.56)" d="M 2849.4130859375 -437.710205078125 L 2841.8056640625 -425.1981811523438 L 2857.00341796875 -425.1804809570312 L 2849.4130859375 -437.710205078125 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_srgkw2 =
    '<svg viewBox="192.6 403.1 3.2 5.2" ><path transform="translate(-249.31, 0.55)" d="M 444.5425415039062 403.763916015625 C 444.233154296875 403.359375 443.9053955078125 403.1570739746094 443.5592651367188 403.1570739746094 C 443.291015625 403.1570739746094 443.0628051757812 403.2522888183594 442.8746032714844 403.442626953125 C 442.6841735839844 403.633056640625 442.5890197753906 403.8623657226562 442.5890197753906 404.1305847167969 C 442.5890197753906 404.3274536132812 442.64306640625 404.5070190429688 442.7512817382812 404.6692504882812 L 443.7897033691406 405.8472290039062 C 443.8524169921875 405.912109375 443.8837890625 405.9889526367188 443.8837890625 406.07763671875 C 443.8837890625 406.1663818359375 443.8524169921875 406.2431335449219 443.7897033691406 406.3080444335938 C 443.7269287109375 406.3707885742188 443.650146484375 406.4021301269531 443.5592651367188 406.4021301269531 C 443.4640502929688 406.4021301269531 443.384033203125 406.3653564453125 443.3191528320312 406.2918090820312 L 442.2644958496094 405.100830078125 C 442.0481567382812 404.8131713867188 441.9400329589844 404.48974609375 441.9400329589844 404.1305847167969 C 441.9400329589844 403.6957397460938 442.1141357421875 403.3128356933594 442.4624328613281 402.9818115234375 C 442.7955932617188 402.666015625 443.1611938476562 402.508056640625 443.5592651367188 402.508056640625 C 443.8923950195312 402.508056640625 444.1812133789062 402.5848388671875 444.4257507324219 402.7384643554688 C 444.6117553710938 402.8552856445312 444.8086547851562 403.045654296875 445.016357421875 403.3095703125 C 445.092041015625 403.4048461914062 445.1299438476562 403.4934692382812 445.1299438476562 403.57568359375 C 445.1299438476562 403.6665649414062 445.0985107421875 403.7433471679688 445.0357666015625 403.8060913085938 C 444.9730224609375 403.8688659667969 444.8963012695312 403.9001770019531 444.805419921875 403.9001770019531 C 444.695068359375 403.9001770019531 444.607421875 403.8547668457031 444.5425415039062 403.763916015625 Z M 442.5792846679688 406.4443359375 C 442.8886413574219 406.8489074707031 443.21533203125 407.0511474609375 443.5592651367188 407.0511474609375 C 443.8297119140625 407.0511474609375 444.0590209960938 406.9559631347656 444.2472534179688 406.7655639648438 C 444.4376220703125 406.5752563476562 444.5328369140625 406.3459167480469 444.5328369140625 406.07763671875 C 444.5328369140625 405.8548583984375 444.4786987304688 405.6752319335938 444.3705749511719 405.5389404296875 L 443.3321228027344 404.3609924316406 C 443.2693481445312 404.2960815429688 443.238037109375 404.2192993164062 443.238037109375 404.1305847167969 C 443.238037109375 404.0419006347656 443.2693481445312 403.965087890625 443.3321228027344 403.9001770019531 C 443.3948974609375 403.8374633789062 443.4705810546875 403.8060913085938 443.5592651367188 403.8060913085938 C 443.6566467285156 403.8060913085938 443.73779296875 403.8428955078125 443.8026733398438 403.9164123535156 L 444.8572998046875 405.1073608398438 C 445.0736389160156 405.3583374023438 445.1818237304688 405.6817626953125 445.1818237304688 406.07763671875 C 445.1818237304688 406.512451171875 445.0076599121094 406.8943176269531 444.6593627929688 407.22314453125 C 444.3262023925781 407.5411682128906 443.95947265625 407.7001953125 443.5592651367188 407.7001953125 C 443.2283020019531 407.7001953125 442.9405517578125 407.6234130859375 442.6961059570312 407.4697570800781 C 442.510009765625 407.3529357910156 442.3131713867188 407.16259765625 442.1054992675781 406.8986511230469 C 442.0297546386719 406.803466796875 441.9919128417969 406.7147827148438 441.9919128417969 406.6325378417969 C 441.9919128417969 406.5416870117188 442.0232543945312 406.4649047851562 442.0860595703125 406.4021301269531 C 442.1487426757812 406.3394165039062 442.2255859375 406.3080444335938 442.3164367675781 406.3080444335938 C 442.4267883300781 406.3080444335938 442.514404296875 406.3534545898438 442.5792846679688 406.4443359375 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_jt1z5 =
    '<svg viewBox="187.4 399.6 14.2 8.2" ><path transform="translate(-31.7, 142.03)" d="M 220.3023681640625 265.7989501953125 C 220.177734375 265.5855712890625 220.0569763183594 265.3808288574219 219.9380798339844 265.1750793457031 C 219.6563110351562 264.6874084472656 219.3771209716797 264.1982421875 219.0924072265625 263.7123413085938 C 219.0490112304688 263.6383361816406 219.0508422851562 263.5838928222656 219.0929718017578 263.5111694335938 C 220.2147827148438 261.5749206542969 221.3349456787109 259.6376953125 222.4526672363281 257.6990966796875 C 222.4961242675781 257.6237182617188 222.5426483154297 257.5961303710938 222.6288757324219 257.5962219238281 C 224.8633270263672 257.5984497070312 227.0977783203125 257.5984802246094 229.3322143554688 257.5960388183594 C 229.4183807373047 257.595947265625 229.4647521972656 257.623779296875 229.5068206787109 257.6978454589844 C 229.7802581787109 258.1792602539062 230.0583801269531 258.6580200195312 230.33544921875 259.1373901367188 C 230.3649291992188 259.1883850097656 230.3973999023438 259.2376403808594 230.4339294433594 259.2964782714844 C 231.3605499267578 258.944580078125 232.28125 258.5948486328125 233.2019653320312 258.2451782226562 C 233.2095642089844 258.255126953125 233.2171478271484 258.2650756835938 233.2247009277344 258.2750244140625 C 232.0750732421875 259.6815185546875 230.9254302978516 261.0880432128906 229.7623596191406 262.5109252929688 C 229.7283020019531 262.456298828125 229.6997985839844 262.4132995605469 229.6739501953125 262.3687744140625 C 229.1959533691406 261.5445556640625 228.7166748046875 260.7210693359375 228.2430114746094 259.8943786621094 C 228.1961364746094 259.8125915527344 228.1470336914062 259.7881469726562 228.0568695068359 259.7883605957031 C 226.6741333007812 259.7911376953125 225.2913818359375 259.7919616699219 223.9086456298828 259.7872009277344 C 223.7987976074219 259.7868041992188 223.7504577636719 259.8321533203125 223.70166015625 259.916748046875 C 222.5877990722656 261.8482055664062 221.4719085693359 263.7784423828125 220.3563537597656 265.7089233398438 C 220.341552734375 265.7344665527344 220.3259887695312 265.7595825195312 220.3023681640625 265.7989501953125 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
const String _svg_xd49wn =
    '<svg viewBox="187.0 403.5 14.2 8.2" ><path transform="translate(-18.59, -16.35)" d="M 205.6300201416016 427.3203125 C 206.7789916992188 425.9156799316406 207.9279479980469 424.5110473632812 209.0869445800781 423.0941772460938 C 209.4305572509766 423.6885375976562 209.76611328125 424.269287109375 210.1019592285156 424.849853515625 C 210.2667083740234 425.1346435546875 210.4352264404297 425.4173278808594 210.5949401855469 425.7049560546875 C 210.6397705078125 425.7856750488281 210.6906433105469 425.81103515625 210.7816467285156 425.810791015625 C 212.1691284179688 425.8077087402344 213.556640625 425.8074340820312 214.9441223144531 425.8113098144531 C 215.0428924560547 425.8115844726562 215.0941772460938 425.7802429199219 215.1421508789062 425.6968688964844 C 216.2367553710938 423.7958374023438 217.333984375 421.8963623046875 218.430908203125 419.9967041015625 C 218.4629821777344 419.9411010742188 218.4973907470703 419.8868713378906 218.5422515869141 419.81298828125 C 218.6771240234375 420.0415649414062 218.8064270019531 420.25732421875 218.9324645996094 420.4749755859375 C 219.20458984375 420.9447631835938 219.4736938476562 421.4162292480469 219.7474975585938 421.8849792480469 C 219.79150390625 421.9603881835938 219.7987060546875 422.015380859375 219.750732421875 422.0982666015625 C 218.633544921875 424.0260009765625 217.5197906494141 425.9557495117188 216.4090728759766 427.88720703125 C 216.3562316894531 427.9790954589844 216.2967834472656 428.0036926269531 216.1971130371094 428.0035705566406 C 213.9781036376953 428.0010375976562 211.7590942382812 428.000732421875 209.5401000976562 428.0043334960938 C 209.4309387207031 428.0045166015625 209.3733215332031 427.9725341796875 209.3194885253906 427.877197265625 C 209.0253295898438 427.3564453125 208.7231140136719 426.8402404785156 208.41748046875 426.3118286132812 C 208.0509948730469 426.4506225585938 207.6908874511719 426.58837890625 207.3297729492188 426.7235107421875 C 206.7720336914062 426.9321899414062 206.2136383056641 427.1390380859375 205.6555480957031 427.3466796875 C 205.6470336914062 427.337890625 205.6385192871094 427.3291015625 205.6300201416016 427.3203125 Z" fill="#ffbb00" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
