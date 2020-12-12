import React from 'react';
import { Laureate } from '../../reducer';

import Icon from './icon';
import Country from './country';

interface Props {
  item: Laureate;
}

export default ({ item }: Props) => (
  <div className='row align-items-center'>
    <div className='col-auto pr-0'>
      <Icon id={item.gender} />
    </div>
    <div className='col-11'>
      <div className='row align-items-center'>
        <div className='col-auto'>
          <h2>{item.name}</h2>
        </div>
        <div className='col-auto pl-0'>{item.awards}</div>
      </div>
      <div className='row'>
        <div className='col-auto'>
          <Country label='Country of birth' country={item.country} />
        </div>
        {item.death ? (
          <div className='col-auto'>
            <Country
              label='Country of death'
              country={item.death.place.countryNow}
            />
          </div>
        ) : (
          <></>
        )}
      </div>
    </div>
  </div>
);
