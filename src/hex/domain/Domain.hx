package hex.domain;

import hex.log.Stringifier;
import hex.error.NullPointerException;
import hex.error.IllegalArgumentException;

/**
 * ...
 * @author Francis Bourre
 */
class Domain
{
    private var _domainName : String;
    private static var _domainNames : Map<String, Domain> = new Map<String, Domain>();

    public function new( domainName : String )
    {
        if ( domainName == null )
        {
            throw new NullPointerException( "Domain's name can't be null" );
        }
        else if ( Domain._domainNames.exists( domainName ) )
        {
            throw new IllegalArgumentException( "Domain has already been registered with name '" + domainName + "'" );
        }
        else
        {
            Domain._domainNames.set( domainName, this );
            this._domainName = domainName;
        }
    }

    public function getName() : String
    {
    return this._domainName;
    }

    public function toString() : String
    {
        return Stringifier.stringify( this ) + " with name '" + this.getName() + "'";
    }
}