// import { useState, type FC } from 'react';
// import Button from '../components/Button';
// import Input from '../components/Input';
// import { useMotdSetMessage } from './wagmi.generated';

// interface ChangeMessageProps {}

// const ChangeMessage: FC<ChangeMessageProps> = () => {
//   const [value, setValue] = useState('');
//   const { write } = useMotdSetMessage({
//     args: [value],
//   });

//   return (
//     <div className="flex flex-col w-full">
//       <Input value={value} onChange={(e) => setValue(e.target.value)} placeholder="New message..." className="mb-4" />
//       <Button disabled={!write || !value} onClick={() => write?.()}>
//         Validate
//       </Button>
//     </div>
//   );
// };

// export default ChangeMessage;

import React, { useState } from 'react';
import Button from '../components/Button';

interface BetProps {}

const Bet: React.FC<BetProps> = () => {
  const [bet, setBet] = useState<number>(0);
  const [balance, setBalance] = useState<number>(10); 
  const [prediction, setPrediction] = useState<string | null>(null);

  const placeBet = (direction: string) => {
    if (bet > 0) {
      setBalance(prevBalance => prevBalance - bet);
      setPrediction(direction);
      console.log(`Transaction envoyée pour placer un pari de ${bet} ETH sur la direction : ${direction}`);
    }
  };

  return (
    <div>
      <h2>Placez votre pari</h2>
      <p>Solde actuel : {balance} ETH</p>
      <input
        type="number"
        placeholder="Montant du pari en ETH"
        value={bet}
        onChange={(e) => setBet(parseInt(e.target.value, 10) || 0)}
      />
      <div className="flex flex-col w-full">
        <Button onClick={() => placeBet('up')}>Plus (Parier à la hausse)</Button>
        <Button onClick={() => placeBet('down')}>Moins (Parier à la baisse)</Button>
      </div>
      <div>
        {prediction && <p>Votre pari : {prediction}</p>}
      </div>
    </div>
  );
};

export default Bet;