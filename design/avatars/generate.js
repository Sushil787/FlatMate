// The Mate avatar faces in flatmates_flutter/assets/avatars: "Notionists" by
// Zoish (CC0), via DiceBear 9. Gender-neutral on purpose: no beards, neutral
// hair. Rebuild: npm i @dicebear/core@9 @dicebear/collection@9, then
// node design/avatars/generate.js flatmates_flutter/assets/avatars
// (add 'preview' to draw the colour circles, for looking at them).
const {createAvatar}=require('@dicebear/core');
const {notionists}=require('@dicebear/collection');
const fs=require('fs');
// One gender-neutral face per Mate colour, in MateColor order.
const faces={
  tomato:  {hair:'hat',       lips:'variant25'},
  sky:     {hair:'variant20', lips:'variant03', glasses:'variant02'},
  plum:    {hair:'variant09', lips:'variant22', body:'variant01'},
  leaf:    {hair:'variant30', lips:'variant14', glasses:'variant08'},
  marigold:{hair:'variant49', lips:'variant30'},
  berry:   {hair:'variant22', lips:'variant03'},
};
const colors={tomato:'c8431f',sky:'2670ad',plum:'8e4ea8',leaf:'1f7a52',marigold:'e0a100',berry:'b8356b'};
const [out, preview]=[process.argv[2], process.argv[3]==='preview'];
for (const [c,f] of Object.entries(faces)) {
  const svg=createAvatar(notionists,{
    seed:'flatmate-'+c, hair:[f.hair], lips:[f.lips],
    glasses:f.glasses?[f.glasses]:undefined, glassesProbability:f.glasses?100:0,
    body:f.body?[f.body]:undefined,
    beardProbability:0, gestureProbability:0, scale:130, translateY:8,
    ...(preview?{radius:50,backgroundColor:[colors[c]]}:{}),
  }).toString().replace(/<metadata[\s\S]*?<\/metadata>/,'');
  fs.writeFileSync(`${out}/${c}.svg`, svg);
}
