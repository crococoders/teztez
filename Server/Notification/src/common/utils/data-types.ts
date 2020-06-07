import {
  some,
  none,
  getRefinement,
  fromNullable,
  fromPredicate,
} from 'fp-ts/lib/Option';
import isBase from '@sindresorhus/is';

export const is = {
  ...isBase,
  nil: isBase.nullOrUndefined,
  nonEmptyString: (value: string | null | undefined): value is string =>
    isBase.nonEmptyString(value),
  positiveInt: (value: unknown): value is number =>
    isBase.integer(value) && value > 0,
};

export const Opt = {
  fromNullable,
  nonEmptyString: fromPredicate(
    getRefinement<string | null | undefined, string>(value =>
      typeof value === 'string' && value.length !== 0 ? some(value) : none,
    ),
  ),
  positiveInt: fromPredicate(
    getRefinement<number | null | undefined, number>(value =>
      typeof value === 'number' && Number.isInteger(value) && value !== 0
        ? some(value)
        : none,
    ),
  ),
};
